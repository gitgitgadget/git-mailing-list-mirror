From: Michael Haggerty <mhagger@alum.mit.edu>
Subject: Re: Review of git multimail
Date: Wed, 03 Jul 2013 13:41:05 +0200
Message-ID: <51D40DD1.8010809@alum.mit.edu>
References: <1372793019-12162-1-git-send-email-artagnon@gmail.com> <51D36BD8.1060909@alum.mit.edu> <CALkWK0=taYiV3UTaj9r-FLdaCeZRzVBTp_MH4sQt8-v+YYqbaA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: Git List <git@vger.kernel.org>
To: Ramkumar Ramachandra <artagnon@gmail.com>
X-From: git-owner@vger.kernel.org Wed Jul 03 13:41:16 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UuLQx-000870-5Y
	for gcvg-git-2@plane.gmane.org; Wed, 03 Jul 2013 13:41:16 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756044Ab3GCLlK (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 3 Jul 2013 07:41:10 -0400
Received: from alum-mailsec-scanner-1.mit.edu ([18.7.68.12]:58899 "EHLO
	alum-mailsec-scanner-1.mit.edu" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753038Ab3GCLlJ (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 3 Jul 2013 07:41:09 -0400
X-AuditID: 1207440c-b7f016d000005997-d7-51d40dd38ef5
Received: from outgoing-alum.mit.edu (OUTGOING-ALUM.MIT.EDU [18.7.68.33])
	by alum-mailsec-scanner-1.mit.edu (Symantec Messaging Gateway) with SMTP id E3.25.22935.3DD04D15; Wed,  3 Jul 2013 07:41:08 -0400 (EDT)
Received: from [192.168.101.152] (mx.berlin.jpk.com [212.222.128.135] (may be forged))
	(authenticated bits=0)
        (User authenticated as mhagger@ALUM.MIT.EDU)
	by outgoing-alum.mit.edu (8.13.8/8.12.4) with ESMTP id r63Bf5c0025828
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NOT);
	Wed, 3 Jul 2013 07:41:06 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:17.0) Gecko/20130623 Thunderbird/17.0.7
In-Reply-To: <CALkWK0=taYiV3UTaj9r-FLdaCeZRzVBTp_MH4sQt8-v+YYqbaA@mail.gmail.com>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprNKsWRmVeSWpSXmKPExsUixO6iqHuF90qgwYkyi1UzH7NbdF3pZnJg
	8tg56y67x+dNcgFMUdw2SYklZcGZ6Xn6dgncGZse8xXsqqy4+fcgSwNjT1wXIyeHhICJxMZH
	v1ghbDGJC/fWs3UxcnEICVxmlFg66TgrhHOVSeLmtJuMIFW8AtoSU7dsZAKxWQRUJXr/b2AG
	sdkEdCUW9TQDxTk4RAXCJK78VoUoF5Q4OfMJC0hYBKjk2SpvkDCzgJJE/+XfLCC2sICKxMXF
	q5khVi1nlLjwuBnsIE6BQIkHsyazgvQyC6hLrJ8nBNErL7H97RzmCYwCs5BsmIVQNQtJ1QJG
	5lWMcok5pbm6uYmZOcWpybrFyYl5ealFuoZ6uZkleqkppZsYIQHKs4Px2zqZQ4wCHIxKPLwO
	zy4FCrEmlhVX5h5ilORgUhLlFQCGtxBfUn5KZUZicUZ8UWlOavEhRgkOZiUR3ol/LgcK8aYk
	VlalFuXDpKQ5WJTEeVWXqPsJCaQnlqRmp6YWpBbBZGU4OJQkeO/zAA0VLEpNT61Iy8wpQUgz
	cXCCDOeSEilOzUtJLUosLcmIB8VofDEwSkFSPEB7WUBu4i0uSMwFikK0nmK05Jh8dst7Ro4D
	P0Dkzfdb3zMKseTl56VKifP+BdknANKQUZoHtw6Wpl4xigN9L8wrCDKWB5ji4Ka+AlrIBLTw
	LzvYwpJEhJRUA2OS7PfO8mV2oczrDQU+BAl6MXzSuHLSb3bh9vVPlc9Y3fvydIf+QZWi6Oqn
	3en+Pq4SZwUW8s68v3leTPCTSa4hu6NkfmXUekpabDr8QKA6fe3ke9NyapxqWzi4 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/229492>

On 07/03/2013 12:23 PM, Ramkumar Ramachandra wrote:
> Michael Haggerty wrote:
>> On 07/02/2013 09:23 PM, Ramkumar Ramachandra wrote:
>>> git_multimail.py wrote:
>>>> #! /usr/bin/env python2
>>>
>>> Do all distributions ship it as python2 now?
>>
>> No, but nor is "python" always Python version 2.x (I believe that Arch
>> Linux now installs Python 3 as "python").  This topic was discussed here
>> [1].  Basically, my reasoning is that (a) PEP 394 [2] says that
>> "python2" is the correct name for a Python 2.x interpreter, (b) I
>> believe that other distros are moving in that direction, and (c) if the
>> script says "python2" but no python2 is installed, the error is pretty
>> obvious, whereas if the script says "python" and that is actually Python
>> 3.x, the error would be more cryptic.
> 
> Yeah, this is good reasoning.  And yes, I'm on Arch: python points to
> python3, and python2 points to python2.  A couple of thoughts while
> we're on the subject:
> 
> 1. We should probably convert git-remote-{hg,bzr} to use this style
> too: they give cryptic errors now, and I have a ~/bin/python pointing
> to python2 which is higher up in $PATH to work around it.  Debian uses
> an alternatives mechanism to have multiple versions of the same
> package, but I personally think the system is ugly.
> 
> 2. Is there a way to determine the python version in-script and
> error-out quickly?  Is it worth the ugliness?

The problems is that the whole script is parsed before execution starts,
so using the wrong interpreter likely leads to a SyntaxError before the
script even gains control.

The correct solution, I'm afraid, is to have a build step that
determines the correct Python shebang contents at build times and
rewrites the script like the filename.perl -> filename transformations
that are already done for Perl.

>>>>             'Command "%s" failed with retcode %s' % (' '.join(cmd), retcode,)
>>>
>>> So cmd is a list.
>>
>> Yes, commands are always lists in my code because it is less error-prone
>> than trying to quote arguments correctly for the shell.  Do you think I
>> should document that here, or elsewhere, or everywhere, or ...?
> 
> If you look at the prototype of execvpe(), the calling semantics are
> immediately clear, but we don't have that luxury in Python: probably
> rename the variable cmd_argv?

Added to to-do list.

> [...]
>>>>     def get_recipients(self, name, default=None):
>>>>         lines = self.get_all(name, default=None)
>>>>         if lines is None:
>>>>             return default
>>>>         return ', '.join(line.strip() for line in lines)
>>>
>>> Ugh.
>>
>> ?
> 
> I would expect it to return a list that can be churned on further, not
> a string that's ready for rendering.  Doesn't it resemble the
> dictionary get(), and even your own get_all() in name and signature?

We support both single and multiple-valued options, and each value can
contain multiple comma-separated RFC 2822 email addresses:

    git config multimailhook.mailinglist "larry@example.com"
    git config --add multimailhook.mailinglist "moe@example.com,
curley@example.com"
    git config --add multimailhook.mailinglist '"Shemp, the other one"
<shemp@example.com>'

(I think that last one is valid.)

So we could turn the arguments into a list, but to be useful it would
require the individual values to be parsed into possibly multiple
addresses.  That seemed overkill, given that we only need the result as
a single string.

> [...]
>>> Dead code?
>>
>> git_multimail is used as a library by migrate-mailhook-config, and that
>> script uses these methods.
> 
> I see.  Perhaps clean separation to avoid confusing readers?

Think of git_multimail.py as a library that can be included, e.g. by a
post-receive script, but just happens to be executable as well.

Splitting it up more would prevent a one-file install, which I think
would be unfortunate.

> [...]
>>>>             try:
>>>>                 value = value % values
>>>>             except KeyError, e:
>>>>                 if DEBUG:
>>>>                     sys.stderr.write(
>>>>                         'Warning: unknown variable %r in the following line; line skipped:\n'
>>>>                         '    %s'
>>>>                         % (e.args[0], line,)
>>>>                         )
>>>
>>> If DEBUG isn't on, you risk leaving the value string interpolated
>>> without even telling the user.  What does it mean to the end user?
>>
>> There are some "nice-to-have" values in the templates that are not
>> necessary and might be missing if the user hasn't gone to the trouble to
>> configure every last setting.  For example, if no emaildomain is defined
>> then the pusher_email cannot be determined, resulting in the Reply-To
>> header being omitted.
>>
>> My assumption is that a sysadmin would turn on DEBUG when testing the
>> script, check that any missing headers are uninteresting, and then turn
>> off DEBUG for production use so that users don't have to see the
>> warnings every time they push.
> 
> Ah, so that is the intended usage.  If the impact of omitting certain
> headers (due to lack of information) doesn't result in unusable emails
> being generated, I think we're good.  Are you sure that doesn't
> happen?

I believe that the Environment classes themselves will scream if a
required value is missing, though of course all bets are off if the user
overrides the templates.

>>>>         raise NotImplementedError()
>>>
>>> Unsure what these are about.
>>
>> These are basically just to allow code sharing across the various Change
>> classes.
> 
> I'm not sure it's worth supporting Python < 2.6, especially if it
> costs more to port it to Python 3+ (no abstract base classes; ugliness
> like this).  Which brings me to: considering that the first commit is
> in late 2012, why didn't you choose to code it in python3 directly?
> Unless I'm mistaken, the only reason git-remote-{bzr,hg} aren't in
> python3 is because the dependencies bzrlib and hglib are in python2.

Yes, someday.  But I think there are still widely-used server
distributions without a solid Python 3.x, and this script will mostly be
used on servers.  Whereas I doubt that there will be any significant
distribution without a Python 2.x for the foreseeable future.

> [...]
>>>>         body = self.generate_email_body(push)
>>>>         if body_filter is not None:
>>>
>>> Redundant "is not None".
>>
>> This way of writing the test is robust against objects for which
>> bool(body_filter) might return False.
> 
> If body_filter isn't a function, we have much larger problems, don't we? ;)
> Nevertheless, I'm not going to argue with idioms (I've not written any
> Python in years now, so I don't know them).

body_filter could be an instance of a class with a __call__() method and
a __nonzero__() method.  Since it is user-provided we should be as
robust as possible.

>>> [...]
>>>>         # First line of commit message:
>>>>         try:
>>>>             oneline = read_git_output(
>>>>                 ['log', '--format=%s', '--no-walk', self.rev.sha1]
>>>>                 )
>>>>         except CommandError:
>>>>             oneline = self.rev.sha1
>>>
>>> What does this mean?  When will you get a CommandError?
>>
>> I can't think of a plausible reason that this command would fail.
>>
>>>                                                          And how do
>>> you respond to it?
>>
>> By using the commit's SHA-1 in place of its subject line.
> 
> What you have written translates to: "If there is a valid commit whose
> subject cannot be determined (empty subject is still determinate), I
> will use the commit's SHA-1 hex in its place", which implies that you
> do not trust git to be sane ;)
> 
> Isn't the entire premise of your script that you have a sane git?

It is rather my own sanity that I doubt more than git's.  But I will
remove this redundant error-handling.

>> Yes, I could do that (though it needs quotes around the key strings).
>> Or the even more attractive
>>
>>     values.update(
>>         rev=self.rev.sha1,
>>         rev_short=self.rev.short,
>>         ...
>>         )
>>
>> I had the latter in an earlier version of the script, but I thought it
>> might be too unfamiliar for non-Python-experts.  I guess I'm using
>> pretty highfalutin Python anyway so this change wouldn't hurt.  What do
>> you think?
> 
> I like pretty, maintainable, modern code with low redundancy.  As a
> general principle, I always tilt towards educating users/ developers
> about new (or "advanced") features, not abstaining from them because
> they are too unfamiliar (or "complicated").
> 
> On this specifically, a beginner can look up help(values.update) to
> understand what the code is doing.  So, yes: values.update() is
> definitely better.

Will change.

>>>>         contents = list(read_git_lines(['cat-file', 'tag', self.new.sha1], keepends=True))
>>>
>>> You could've easily batched this.
>>
>> I don't understand what you mean.
> 
> Whenever I call cat-file from a script, I always find myself using the
> --batch variant.

OK, now I understand what you mean.  Yes, if people complain about
performance, this is one of the possibilities that I have in mind.

>>> Way too many git invocations, I think.
>>
>> Luckily git is very fast :-)
>>
>> I'm not to worried about performance here.  The script will typically
>> only be run on pushes, and most pushes affect only one or a few
>> references.  I don't think these few git invocations will be prohibitive.
> 
> I personally push very often, so it's not a problem.  I'm thinking of
> a mirroring batched push, where the maintainer pushes out history to a
> "release" server every major release (every few months): is the script
> intended to be used in such a scenario, when multiple refs and tags
> are updated non-trivially?

The script certainly supports such scenarios (at least modulo bugs).
Performance in a script like this is something that I try not to put
extra work into unless there are obvious concerns or until somebody
complains.

>>> If you want to DWIM when the configuration variable is missing, do it
>>> fully using a list of good candidates like /usr/lib/sendmail,
>>> /usr/sbin/sendmail, /usr/ucblib/sendmail, /usr/bin/msmtp.
>>
>> OK, I just added /usr/sbin/sendmail and /usr/lib/sendmail, which are the
>> paths checked by "git send-mail".
> 
> I'm on Arch, and sendmail is dead (only available in AUR now).  I
> think we should support modern sendmail-compatible alternatives like
> msmtp (which I have and use).

It's configurable.  This is the kind of thing that I would expect the
sysadmin (or the packager) to be familiar with, and I'd rather leave it
to them than make lots of wild guesses about what might be installed.

AFAIK there is a rather well-established convention that *whatever* mail
program is installed, it should put some kind of sendmail-compatible
binary at /usr/sbin/sendmail.  Perhaps you should suggest this to the
msmtp packager?

>>>                                                            Also, what
>>> happened to our faithful 'git send-email' Perl script?  Isn't that
>>> most likely to be installed?
>>
>> We could use "git send-email" to generate and send the revision emails,
>> but then we would lose most control over the contents of the emails.
> 
> I'm talking about the <file>... form.  Does it necessarily mangle the
> headers of an mbox that is fed to it, or am I missing something?

I only glanced at the documentation but it didn't look like an obvious
improvement over invoking sendmail directly or using smtplib.  But it
would be easy to add another Mailer class that delegates to "git
send-email" if somebody is motivated to do so.

>>>> class Environment(object):
>>>
>>> New-style class.  I wonder why you suddenly switched.
>>
>> ?  All of the classes are new-style classes.
> 
> When you say class Foo:, aren't you declaring an old-style class by
> default in python2?  New-style classes are those that explicitly
> inherit from object (implicit in python3).

That is correct.  But I don't think I use "class Foo:" anywhere in
git-multimail; in other words, I think I only use new-style classes in
this project.

>>>> class GenericEnvironment(
>>>>     ProjectdescEnvironmentMixin,
>>>>     ConfigMaxlinesEnvironmentMixin,
>>>>     ConfigFilterLinesEnvironmentMixin,
>>>>     ConfigRecipientsEnvironmentMixin,
>>>>     PusherDomainEnvironmentMixin,
>>>>     ConfigOptionsEnvironmentMixin,
>>>>     GenericEnvironmentMixin,
>>>>     Environment,
>>>>     ):
>>>>     pass
>>>
>>> Sigh.  I might as well be reading some Java now :/
>>
>> No, Java doesn't allow multiple inheritance :-)
> 
> Ha, yes: I meant in the way you factory'ified everything.  I don't
> recall seeing this kind of code in a real-world application though: I
> skimmed through Django's code many years ago, and haven't found such a
> pattern.  I have seen instances where multiple inheritance may be
> classified as borderline useful, but nothing as extensive as this.
> Additionally, Ruby does not have multiple inheritance.  So, I tilt
> towards the conclusion that multiple inheritance is Bad and Wrong.
> Then again, I'm not an OO person in general, so I can't have a mature
> opinion on the subject.  Can you present a case for this kind of
> extensive usage quoting real-world examples?

Multiple inheritance has to be used with great care.  I've never used it
this extensively before, so it was kindof an experiment for me.  But I
am pleased with the result, especially that it makes it possible to
separate concerns quite well.

I believe that Zope uses mixins quite extensively (and did so back in
the very old days), though that is not necessarily a strong endorsement :-)

> [...]
>> git_multimail.py is 2398 lines of Python script, including comments and
>> string literals.  The fraction of that code that is dedicated to
>> configurability is approximately 1000 lines.  Relative to
>> post-receive-email, it adds
>>
>> * much more configurability, without the need to edit the script.
> 
> So this is the main selling point.

Yes, that plus the one-email-per-commit feature and (hopefully!) better
maintainability due to the use of a more powerful language are the main
selling points.

> [...]
>> Regarding efficiency, I don't think it is a problem.  But patches or
>> concrete suggestions are certainly welcome.
> 
> Pre-optimization is the root of all evil :)  Can you give us some
> numbers from real-world usecases, so we know whether or not it _needs_
> to be optimized?  I ran your test script (test-email, I think) and it
> generated 35 emails in ~10 seconds; but the repository was
> super-trivial.

We use the script at work for our main Git repo, which is quite large.
On the same repo we use a rather extensive pre-receive hook as well, so
it is not obvious what part of the push time comes from each script.
Together they create a noticeable delay if many commits are being pushed
at once, but (except when I once pushed thousands of commits at a time)
the total delay is max a few seconds.

Thanks again for your feedback!
Michael

-- 
Michael Haggerty
mhagger@alum.mit.edu
http://softwareswirl.blogspot.com/
