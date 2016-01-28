From: =?windows-1252?Q?Torsten_B=F6gershausen?= <tboegi@web.de>
Subject: Re: eol round trip Was: [PATCH] travis-ci: run previously failed
 ....
Date: Thu, 28 Jan 2016 07:20:58 +0100
Message-ID: <56A9B34A.1060205@web.de>
References: <DBA834D2-BFC9-4A2F-94D9-A1D0D60377BD@gmail.com>	<20160122023359.GA686558@vauxhall.crustytoothpaste.net>	<20160122055255.GA14657@sigill.intra.peff.net>	<20160122060720.GA15681@sigill.intra.peff.net>	<20160124143403.GL7100@hank>	<xmqqd1sqd9sq.fsf@gitster.mtv.corp.google.com>	<xmqq8u3ed45r.fsf@gitster.mtv.corp.google.com>	<20160125144250.GM7100@hank>	<xmqqk2mxa7ug.fsf@gitster.mtv.corp.google.com>	<xmqqegd5fht9.fsf@gitster.mtv.corp.google.com>	<20160127151602.GA1690@ecki.hitronhub.home> <xmqqd1sm9730.fsf@gitster.mtv.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Cc: Thomas Gummerer <t.gummerer@gmail.com>, Jeff King <peff@peff.net>,
	=?windows-1252?Q?Torsten_B=F6gershausen?= <tboegi@web.de>,
	"brian m. carlson" <sandals@crustytoothpaste.net>,
	Lars Schneider <larsxschneider@gmail.com>,
	Mike Hommey <mh@glandium.org>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>,
	Clemens Buchacher <drizzd@aon.at>
X-From: git-owner@vger.kernel.org Thu Jan 28 07:22:03 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aOfxx-0008Kx-PP
	for gcvg-git-2@plane.gmane.org; Thu, 28 Jan 2016 07:22:02 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933934AbcA1GV6 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 28 Jan 2016 01:21:58 -0500
Received: from mout.web.de ([212.227.15.4]:53511 "EHLO mout.web.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S933765AbcA1GV4 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 28 Jan 2016 01:21:56 -0500
Received: from [192.168.88.199] ([194.47.243.242]) by smtp.web.de (mrweb004)
 with ESMTPSA (Nemesis) id 0LzmLr-1a2pSP0EBH-014xgg; Thu, 28 Jan 2016 07:21:02
 +0100
User-Agent: Mozilla/5.0 (X11; Linux i686; rv:31.0) Gecko/20100101 Icedove/31.8.0
In-Reply-To: <xmqqd1sm9730.fsf@gitster.mtv.corp.google.com>
X-Provags-ID: V03:K0:FuNaAL0I9PkDpgFlQOTjYip0ovI3o+P8+cWdba58Y5Hkk/V7bfc
 mdBzGeMCDWfIWuRPJySiF1C/qa7L6RHGC5uMGq66hoinmwHSX+ZeW7HEA3/s2sIjAkR1ZcI
 sKRJZxxmBIYBMafjrvIjuBcpsUvqQFOKo3G8lGneKeo1DVnXsAgfaCmN6e2aB3WutGyUtev
 VBloxDCk2npkIy7H0+mRw==
X-UI-Out-Filterresults: notjunk:1;V01:K0:+cH47swJbME=:118SQUEEofs9fcFzV2sRpp
 6CeNXl8I8uNrkCMS0lo/n61A+7ydufhbZO/dzBbBvZV9kbIQcFBWsXcanmo5ghIGrMCWGQONT
 yE5JE8+rZxWiEiZFgQ2rCmHfGWndU0Xeqp03BuQRVI1QUw4l84aM/JSbTAbkm9TgXBcrEh+HO
 tyvOPJ/j6g3Nb+Q18wdO6YYt6Xbrb6X6oG1S6+UpRclx8rkFMdo1F37Gcn4DeFa21I0Vu7AP1
 Qik3/otDvDvFil43QUddvxJGghySM5UkkZLt2SA24CWx6otOVAJILYiIAFUmXD/+c8SZZaUyC
 6GI57tsGK6/30AWSeR8mQJQqyWCimrd3Uze5Myh4ntFm0vz/7QrV56PK2MUIi+8jj4WDK6PuN
 +mIXBjO2d/1vygnDDNtk1ghW5MjRzBPaIMI0Wuxf2qQbaj64TXJKjSlqgJX++zXxKc4j6vBgu
 izjmcQCkZdQLeJRlLnREfF2N+2hkus/WnqO4foMESQeC7NNs1mylo0zharFW67UB5Qr2w/FST
 3Pa2tjWxKABcK2tr52RNAVgCUam+3zB4Vt8zO/P6lSOrTEhq+NqNdeeH/wGlBEZ7ht5Jv1ZFI
 jKfZuh6FhNEMqEf6Kijvvhx97JPJUcLfwmG2FqgRR0081ctI+Ih587PI4CKTJkyllnGbn5gMW
 TbonO0PA4P+/tONx+PqRc+3Jx/sEeRI+bbQm3mFkJFfM87EoVpMLKEeiSlBMFz3LO3N2OkZUm
 MzP7p3pGm3X1I8OMD9XR1rCISrMIWxp7piNIKF/7PvW04lSCRARm1l7mnKQNzPSGzla2yMbN 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/284980>

On 01/27/2016 08:05 PM, Junio C Hamano wrote:
(Changed the topic, 2 notes inside)
> Clemens Buchacher <drizzd@aon.at> writes:
>
>> Coming back to "[PATCH] optionally disable gitattributes": The topics
>> are related, because they both deal with the situation where the work
>> tree has files which are not normalized according to gitattributes. But
>> my patch is more about saying: ok, I know I may have files which need to
>> be normalized, but I want to ignore this issue for now. Please disable
>> gitattributes for now, because I want to work with the files as they are
>> committed. Conversely, the discussion here is about how to reliably
>> detect and fix files which are not normalized.
git ls-files --eol can detect that (as Junio pointed out)

> I primarily wanted to make sure that you understood the underlying
> issue, so that I do not have to go back to the basics in the other
> thread.  And it is clear that you obviously do, which is good.
>
> Here, you seem to think that what t0025 wants to see happen is
> sensible, judging by the fact that you call "rm .git/index && git
> reset" a "fix".
>
> My take on this is quite different.  After a "reset --hard HEAD", we
> should be able to trust the cached stat information and have "diff
> HEAD" say "no changes".  That is what you essentially want in the
> other thread, if I understand you correctly, and in an ideal world
> where the filesystem timestamp has infinite precision, that is what
> would happen in t0025, always "breaking" its expectation.  The real
> world has much coarser timestamp granularity than ideal, and that is
> why the test appear to be "flaky", failing to give "correct" outcome
> some of the time--but I'd say that it is expecting a wrong thing.
>
> An index entry that has data that does not round-trip when it goes
> through convert_to_working_tree() and then convert_to_git() "breaks"
> this arrangement, and I'd view it as the user having an inconsistent
> data.  It is like you are in a repository that still has an unmerged
> paths--you cannot proceed before you resolve them.
This is actually bringing some light to me: the round-trip test.
There are this "well known but less well document" situations where we 
break that rule:
- files are checked in with CRLF into the repo.
- .gittatributes is set to "text" later.
2 different ways to handle it:
- keep the eol at checkout, normalize at checkin -> roundtrip broken
- keep the eol at checkout and checkin -> roundtrip OK

- files with mixed line endings in the repo:
Same here: 2 different ways to handle it:
- keep the eol at checkout, normalize at checkin -> roundtrip broken
- keep the eol at checkout and checkin -> roundtrip OK

- files with CRCRLF line endings in the repo:
Same here: 2 different ways to handle it:
- keep the eol at checkout, normalize at checkin -> roundtrip broken
- keep the eol at checkout and checkin -> roundtrip OK

My feeling is that we should simply say:
You user set attribute to "text" and by doing that, you promised to have 
files
with LF only in the index.
If you break that promise, Git does  not know, what you really want.
- It may be a situation where you write a shell script which for some 
reasons
   needs a '\015' at the end of a line, and Git may treat it wrong by 
assuming
   that this is a CRLF line ending (end converts it into LF)
- It may be that you want CRLF because you added a Windows .BAT file.
   It may be that you use git.git and another implementation of Git, 
which doesn't
   support attributes at all, so that a save way to do this is to just 
commit CRLF.
- It may be that this is a historical issue.
   Everybody using the project uses git that understands .gitattributes,
   so someone may fix it some day.

Can Git make this decision ?

When core.autocrlf is true (and no attributes are set), then the 
conversion of line ending is disabled.
On 01/27/2016 08:05 PM, Junio C Hamano wrote:
(Changed the topic, 2 notes inside)
> Clemens Buchacher <drizzd@aon.at> writes:
>
>> Coming back to "[PATCH] optionally disable gitattributes": The topics
>> are related, because they both deal with the situation where the work
>> tree has files which are not normalized according to gitattributes. But
>> my patch is more about saying: ok, I know I may have files which need to
>> be normalized, but I want to ignore this issue for now. Please disable
>> gitattributes for now, because I want to work with the files as they are
>> committed. Conversely, the discussion here is about how to reliably
>> detect and fix files which are not normalized.
git ls-files --eol can detect that (as Junio pointed out)

> I primarily wanted to make sure that you understood the underlying
> issue, so that I do not have to go back to the basics in the other
> thread.  And it is clear that you obviously do, which is good.
>
> Here, you seem to think that what t0025 wants to see happen is
> sensible, judging by the fact that you call "rm .git/index && git
> reset" a "fix".
>
> My take on this is quite different.  After a "reset --hard HEAD", we
> should be able to trust the cached stat information and have "diff
> HEAD" say "no changes".  That is what you essentially want in the
> other thread, if I understand you correctly, and in an ideal world
> where the filesystem timestamp has infinite precision, that is what
> would happen in t0025, always "breaking" its expectation.  The real
> world has much coarser timestamp granularity than ideal, and that is
> why the test appear to be "flaky", failing to give "correct" outcome
> some of the time--but I'd say that it is expecting a wrong thing.
>
> An index entry that has data that does not round-trip when it goes
> through convert_to_working_tree() and then convert_to_git() "breaks"
> this arrangement, and I'd view it as the user having an inconsistent
> data.  It is like you are in a repository that still has an unmerged
> paths--you cannot proceed before you resolve them.
This is actually bringing some light to me: the round-trip test.
There are this "well known but less well document" situations where we 
break that rule:
- files are checked in with CRLF into the repo.
- .gittatributes is set to "text" later.
2 different ways to handle it:
- keep the eol at checkout, normalize at checkin -> roundtrip broken
- keep the eol at checkout and checkin -> roundtrip OK

- files with mixed line endings in the repo:
Same here: 2 different ways to handle it:
- keep the eol at checkout, normalize at checkin -> roundtrip broken
- keep the eol at checkout and checkin -> roundtrip OK

- files with CRCRLF line endings in the repo:
Same here: 2 different ways to handle it:
- keep the eol at checkout, normalize at checkin -> roundtrip broken
- keep the eol at checkout and checkin -> roundtrip OK

My feeling is that we should simply say:
You user set attribute to "text" and by doing that, you promised to have 
files
with LF only in the index.
If you break that promise, Git does  not know, what you really want.
- It may be a situation where you write a shell script which for some 
reasons
   needs a '\015' at the end of a line, and Git may treat it wrong by 
assuming
   that this is a CRLF line ending (end converts it into LF)
- It may be that you want CRLF because you added a Windows .BAT file.
   It may be that you use git.git and another implementation of Git, 
which doesn't
   support attributes at all, so that a save way to do this is to just 
commit CRLF.
- It may be that this is a historical issue.
   Everybody using the project uses git that understands .gitattributes,
   so someone may fix it some day.

Can Git make this decision ?

When core.autocrlf is true (and no attributes are set), then the 
conversion of line ending is disabled.
On 01/27/2016 08:05 PM, Junio C Hamano wrote:
(Changed the topic, 2 notes inside)
> Clemens Buchacher <drizzd@aon.at> writes:
>
>> Coming back to "[PATCH] optionally disable gitattributes": The topics
>> are related, because they both deal with the situation where the work
>> tree has files which are not normalized according to gitattributes. But
>> my patch is more about saying: ok, I know I may have files which need to
>> be normalized, but I want to ignore this issue for now. Please disable
>> gitattributes for now, because I want to work with the files as they are
>> committed. Conversely, the discussion here is about how to reliably
>> detect and fix files which are not normalized.
git ls-files --eol can detect that (as Junio pointed out)

> I primarily wanted to make sure that you understood the underlying
> issue, so that I do not have to go back to the basics in the other
> thread.  And it is clear that you obviously do, which is good.
>
> Here, you seem to think that what t0025 wants to see happen is
> sensible, judging by the fact that you call "rm .git/index && git
> reset" a "fix".
>
> My take on this is quite different.  After a "reset --hard HEAD", we
> should be able to trust the cached stat information and have "diff
> HEAD" say "no changes".  That is what you essentially want in the
> other thread, if I understand you correctly, and in an ideal world
> where the filesystem timestamp has infinite precision, that is what
> would happen in t0025, always "breaking" its expectation.  The real
> world has much coarser timestamp granularity than ideal, and that is
> why the test appear to be "flaky", failing to give "correct" outcome
> some of the time--but I'd say that it is expecting a wrong thing.
>
> An index entry that has data that does not round-trip when it goes
> through convert_to_working_tree() and then convert_to_git() "breaks"
> this arrangement, and I'd view it as the user having an inconsistent
> data.  It is like you are in a repository that still has an unmerged
> paths--you cannot proceed before you resolve them.
This is actually bringing some light to me: the round-trip test.
There are this "well known but less well document" situations where we 
break that rule:
- files are checked in with CRLF into the repo.
- .gittatributes is set to "text" later.
2 different ways to handle it:
- keep the eol at checkout, normalize at checkin -> roundtrip broken
- keep the eol at checkout and checkin -> roundtrip OK

- files with mixed line endings in the repo:
Same here: 2 different ways to handle it:
- keep the eol at checkout, normalize at checkin -> roundtrip broken
- keep the eol at checkout and checkin -> roundtrip OK

- files with CRCRLF line endings in the repo:
Same here: 2 different ways to handle it:
- keep the eol at checkout, normalize at checkin -> roundtrip broken
- keep the eol at checkout and checkin -> roundtrip OK

My feeling is that we should simply say:
You user set attribute to "text" and by doing that, you promised to have 
files
with LF only in the index.
If you break that promise, Git does  not know, what you really want.
- It may be a situation where you write a shell script which for some 
reasons
   needs a '\015' at the end of a line, and Git may treat it wrong by 
assuming
   that this is a CRLF line ending (end converts it into LF)
- It may be that you want CRLF because you added a Windows .BAT file.
   It may be that you use git.git and another implementation of Git, 
which doesn't
   support attributes at all, so that a save way to do this is to just 
commit CRLF.
- It may be that this is a historical issue.
   Everybody using the project uses git that understands .gitattributes,
   so someone may fix it some day.

Can Git make this decision ?

When core.autocrlf is true (and no attributes are set), then the 
conversion of line endings is disabled.
See convert.v "This is the new safer autocrlf handling",
commit fd6cce9e

So the round trip is achieved when core.autocrlf=true,
but no longer when attributes are added.
[]


> Anyway.
>
> As to your patch in the other thread, here is what I think:
>
>   (1) When you know (or perhaps your CI knows) that the working tree
>       has never been modified since you did "reset --hard HEAD" (or
>       its equivalent, like "git checkout $branch" from a clean
>       state), these paths with inconsistent data would break the
>       usual check to ask "is the working tree clean?"  That is a
>       problem and we need a way to ensure that the working tree is
>       always judged to be clean immediately after "reset --hard
>       HEAD".  IOW, I agree with you that the issue you are trying to
>       solve is worth solving.
>
>   (2) Regardless of the "inconsistent data breaking the cleanliness
>       check" issue, it may be handy to have a way to temporarily
>       disable the attributes, i.e. allow us to ask "what happens if
>       there is no attributes defined?"  IOW, I am saying that the
>       change in the patch is not without merit.
>
> In addition to (1), I further think that this sequence should not
> report that the path F is modified:
>
>       # Write F from HEAD to the working tree, after passing it
>       # through convert_to_working_tree()
>       $ git reset --hard HEAD
>
>       # Force the re-reading, without changing the contents at all
>       $ cp F F.new
>       $ mv F.new F
>
>       $ git diff HEAD
>
> which is broken by paths with inconsistent data.  Your CI would want
> a way to make that happen.
>
> However, I do not think disabling attributes (i.e. (2)) is a
> solution to the issue (i.e. (1)), which we just agreed to be an
> issue that is worth solving, for at least two reasons.
>
>   * Even without any attributes, core.autocrlf setting can get the
>     data in your index (whose lines can be terminated with CRLF) into
>     the same "inconsistent data" situation.  Disabling attribute
>     handling would not have any effect on that codepath, I think.
>
I don't think so, see above.
