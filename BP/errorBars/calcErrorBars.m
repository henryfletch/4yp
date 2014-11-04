% Calculates the actual value of the error bars given the total number of
% monte carlo iterations vs the number of error blocks
% SOURCE: MacKay LDPC paper appendix!
% Type is either 'pos' or 'neg' for +ve/-ve bars.
function p = calcErrorBars(type,r,n)

%Need to find if any r are zero first, since handled differently
if strcmp(type,'pos')
    for i = 1:length(r)
        if r(i) == 0
            p(i) = 1 - exp(-2/n(i));
        else
            p(i) = (r(i)/n(i))*exp(2*sqrt((n(i)-r(i))/(r(i)*n(i))));
        end
    end
end

if strcmp(type,'neg')
    for i = 1:length(r)
        if r(i) == 0
            p(i) = 0;
        else
            p(i) = (r(i)/n(i))*exp(-2*sqrt((n(i)-r(i))/(r(i)*n(i))));
        end
    end
end
