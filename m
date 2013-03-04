From: Paul Campbell <pcampbell@kemitix.net>
Subject: Re: Subtree in Git
Date: Mon, 4 Mar 2013 22:33:23 +0000
Message-ID: <CALeLG_mMMZ2Gh=mz_EQceTaqi9XK1ty2SaCbH5x23zsS1Wu1Dg@mail.gmail.com>
References: <CAE1pOi2uT=wipyrOYCwy9QuXnXFV27F1gN3Ej-RaSr-fegQCfA@mail.gmail.com>
	<nngk410vrja.fsf@transit.us.cray.com>
	<4F9FA029.7040201@initfour.nl>
	<87fwbgbs0h.fsf@smith.obbligato.org>
	<7v8vh78dag.fsf@alter.siamese.dyndns.org>
	<4FA82799.1020400@initfour.nl>
	<nngzk9jvemb.fsf@transit.us.cray.com>
	<nngaa0z3p8b.fsf@transit.us.cray.com>
	<87bokpxqoq.fsf@smith.obbligato.org>
	<4FD89383.70003@initfour.nl>
	<nng4npe6zsj.fsf@transit.us.cray.com>
	<50830374.9090308@initfour.nl>
	<7vbofwgwso.fsf@alter.siamese.dyndns.org>
	<5084102A.2010006@initfour.nl>
	<nnga9vefu1v.fsf@transit.us.cray.com>
	<508A8BD3.9020901@initfour.nl>
	<2DDAA35052EA4F88A6EAC4FBDDF7FCCD@rr-dav.id.au>
	<loom.20130301T032627-983@post.gmane.org>
	<CALeLG_maSpjVtO3swZAWV12Cr7rDWOaJ=Jh8zw5tJn0EGGW+fA@mail.gmail.com>
	<CACPE+fvuKiYmmGfJ=A_DZyOi+MiQQ3SgY+QyX5L08XK8TMwzEw@mail.gmail.com>
	<CALeLG_=Yy0TkY-vY8AE9CtXhs4zF8kjdQBNdp+N4yhFmHM79RA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: Kindjal <kindjal@gmail.com>, git <git@vger.kernel.org>
To: David Michael Barr <b@rr-dav.id.au>
X-From: git-owner@vger.kernel.org Mon Mar 04 23:33:54 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UCdxB-0004l8-TW
	for gcvg-git-2@plane.gmane.org; Mon, 04 Mar 2013 23:33:54 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932709Ab3CDWd0 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 4 Mar 2013 17:33:26 -0500
Received: from mail-ea0-f175.google.com ([209.85.215.175]:41063 "EHLO
	mail-ea0-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932378Ab3CDWdZ (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 4 Mar 2013 17:33:25 -0500
Received: by mail-ea0-f175.google.com with SMTP id d1so953346eab.20
        for <git@vger.kernel.org>; Mon, 04 Mar 2013 14:33:23 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=mime-version:x-received:x-originating-ip:in-reply-to:references
         :date:message-id:subject:from:to:cc:content-type:x-gm-message-state;
        bh=CNDM4KeqfBxg9fsX/Q2VthS5eHKddJZC9/YnaAkozMY=;
        b=eMbT3+GWzQHDfJyJJGr9ZT1T70YffMpLvYcCr3OdGuOkew/tw+oOnejIxMIWa4OdFv
         F79UQjWBFDLmlYZSq95CfkAeh0xRdMbbwhU3NQtvw3vTDqQogsr7yXt+o8QUtei/pmeQ
         P/ak6v2s4G3id4Yiosp43y2CAVuoi7ppN9bxpZrjjggd1iKn/E4QRTn6kqB/4oIPafBr
         6McS39y0aB8miGOv65djoov+zQTm7AUGPiTH3UMIyUh6u0Hc3k3/IZfl/DH62vYJ81qT
         Rx74RnW9kb28dezkXuH4hi3yvpan6TnCHkB6xEnuwKqLT18S3jnx3573wMvknlP/Yvs4
         iF9w==
X-Received: by 10.14.214.66 with SMTP id b42mr63712005eep.34.1362436403294;
 Mon, 04 Mar 2013 14:33:23 -0800 (PST)
Received: by 10.14.45.1 with HTTP; Mon, 4 Mar 2013 14:33:23 -0800 (PST)
X-Originating-IP: [2.102.85.162]
In-Reply-To: <CALeLG_=Yy0TkY-vY8AE9CtXhs4zF8kjdQBNdp+N4yhFmHM79RA@mail.gmail.com>
X-Gm-Message-State: ALoCoQmsOzpsmEq3jPU74Y+w3WVnhj7XajTEeklffYFxSIFseeOD0MygvRE2xGpE/qXsiFY8g38M
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/217415>

On Sat, Mar 2, 2013 at 5:43 PM, Paul Campbell <pcampbell@kemitix.net> wrote:
> On Sat, Mar 2, 2013 at 11:21 AM, David Michael Barr <b@rr-dav.id.au> wrote:
>> On Sat, Mar 2, 2013 at 9:05 AM, Paul Campbell <pcampbell@kemitix.net> wrote:
>>> On Fri, Mar 1, 2013 at 2:28 AM, Kindjal <kindjal@gmail.com> wrote:
>>>> David Michael Barr <b <at> rr-dav.id.au> writes:
>>>>
>>>>> From a quick survey, it appears there are no more than 55 patches
>>>>> squashed into the submitted patch.
>>>>> As I have an interest in git-subtree for maintaining the out-of-tree
>>>>> version of vcs-svn/ and a desire to improve my rebase-fu, I am tempted
>>>>> to make some sense of the organic growth that happened on GitHub.
>>>>> It doesn't appear that anyone else is willing to do this, so I doubt
>>>>> there will be any duplication of effort.
>>>>>
>>>>
>>>> What is the status of the work on git-subtree described in this thread?
>>>> It looks like it's stalled.
>>>>
>>>
>>> I hadn't been aware of that patch. Reading the thread David Michael
>>> Barr was going to try picking the patch apart into sensible chunks.
>>>
>>
>> Sorry for not updating the thread. I did end up moving onto other things.
>> I quickly realised the reason for globbing all the patches together was
>> that the individual patches were not well contained.
>> That is single patches with multiple unrelated changes and multiple
>> patches changing the same things in different directions.
>> To me this means that the first step is to curate the history.
>>
>>> If this work is still needing done I'd like to volunteer.
>>
>> You're most welcome. Sorry again for abandoning the thread.
>>
>> --
>> David Michael Barr
>
> Okay, I'll start picking the patch apart this week then feedback when
> I have a plan to tackle it all.
>
> --
> Paul [W] Campbell

>From a comparison of the tip for helmo's subtree-updates branch and
the current master these are the changes and features that the patch
is providing.  I've listed the changes briefly per file, with a note
of the general action I plan to take. This is based on a simple diff,
so some changes are actually reversions to recent commits, which I
have tried to note.

Makefile

	* Regresses two recent commits (8165be064e and d86848228f)
	* ACTION: Ignore file

README.md

	* Adds a markdown readme file (that github likes to have in root)
	* Includes some install instructions in a pseudo man page format
	* The INSTALL file covers all the information contained and is more up-to-date
	* ACTION: Ignore file

git-subtree.sh

	* OPTS_SPEC
		* pull/push: options for repository and refspec are both optional,
[<repository> [<refspec>]]
		* new sub-command: pull-all
		* new sub-command: push-all
		* new sub-command: list
		* new sub-command: from-submodule
		* new sub-command: prune
		* new sub-command: diff
		* new option for push: --force
	* Trailing slash on prefix is removed
	* Different pretty log format in cmd_commit getting piped to set some
environment variables
		* Would revert: a5b8e28e4e
		* Ignoring this change
	* Removes all tests in cmd_add to check that refspec is valid
		* I've posted a patch with new tests to the list recently that would
go in here
	* Change reference to 'commit' into 'refspec' in error message in cmd_add
	* Stores subtree metadata in .gittrees as:
		[subtree "$dir"]
			url = $repository
			path = $dir
			branch = $refspec
	* Inadvertently commited a change to the linefeed character in
cmd_split for the activity indicator
	* cmd_pull/cmd_push: reads options from .gitrees if not provided on
the command line
	* Implementation of cmd_diff
		* fetches remote repo as a temporary git-remote then uses
git-diff-tree to compare before removing the temporary git-remote
	* Implementation of cmd_list as plain wrapper to new functions subtree_list
		* Iterates over subtrees listed in .gittrees and prints out their details
		* Dubious about greps used to get list from .gittrees
	* Implementation of cmd_from-submodule
		* Converts a git-submodule into a git-subtree
	* Implementation of cmd_prune
		* Removes entries from .gittrees where the $dir is missing
		* Dubious about greps used to get list from .gittrees
	* Implementation of cmd_pull-all
		* Performs a git-subtree pull for each subtree
		* Dubious about greps used to get list from .gittrees
	* Implementation of cmd_push-all
		* Perfroms a git-subtree push for each subtree
		* Dubious about greps used to get list from .gittrees

git-subtree.txt

	* Adds brief descriptions for commands:
		* pull-all
		* push-all
		* list
		* from-submodule
		* prune
		* diff ("TO BE DOCUMENTED")
	* Notes optional -f|--force for push sub-command
	* fixes a typo in text for Example 1 (s/incldued/included/)

t/t7900.sh

	* Add numeric comments for each test
		* recently removed (144797d720) in master so don't add them back
	* ACTION: Ignore file

test.sh

	* Legacy tests
	* ACTION: Ignore file

My next step will be to find the commits (from helmo's
subtree-updates-merged branch) that provide the features above that I
want to keep and cherry-pick them into a new branch (or two).

-- 
Paul [W] Campbell
