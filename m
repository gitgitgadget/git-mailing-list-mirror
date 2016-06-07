From: =?UTF-8?Q?Torsten_B=c3=b6gershausen?= <tboegi@web.de>
Subject: Re: Minor Bug in Renaming Branches
Date: Tue, 7 Jun 2016 06:13:14 +0200
Message-ID: <575649DA.4080702@web.de>
References: <CA+wHs3MSax1eo9V_5hnsbEte0k5tX22dAgSUAEzN7aw22rUnhA@mail.gmail.com>
 <54505ef2-7db6-8bc4-0ffb-0ac28c7d6046@web.de>
 <CAGZ79kb77m8ymDkJGMaWi8yOdSphpYifDPHQ=+nZMBhRi47i9w@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Samuel Lijin <samuel.lijin@formlabs.com>,
	"git@vger.kernel.org" <git@vger.kernel.org>
To: Stefan Beller <sbeller@google.com>,
	=?UTF-8?Q?Torsten_B=c3=b6gershausen?= <tboegi@web.de>
X-From: git-owner@vger.kernel.org Tue Jun 07 06:13:35 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1bA8OQ-0005OA-CS
	for gcvg-git-2@plane.gmane.org; Tue, 07 Jun 2016 06:13:30 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752727AbcFGENZ convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 7 Jun 2016 00:13:25 -0400
Received: from mout.web.de ([212.227.15.4]:61102 "EHLO mout.web.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750788AbcFGENZ (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 7 Jun 2016 00:13:25 -0400
Received: from [192.168.88.199] ([194.47.243.242]) by smtp.web.de (mrweb004)
 with ESMTPSA (Nemesis) id 0LyftH-1bUsno12rX-0166KB; Tue, 07 Jun 2016 06:13:19
 +0200
User-Agent: Mozilla/5.0 (X11; Linux i686; rv:38.0) Gecko/20100101
 Icedove/38.7.0
In-Reply-To: <CAGZ79kb77m8ymDkJGMaWi8yOdSphpYifDPHQ=+nZMBhRi47i9w@mail.gmail.com>
X-Provags-ID: V03:K0:+aWykPR5+ORxCwkO1S4YY2S0K6sU0qUj9ZBVI8Hb4ezE02frHBI
 Xvk5R3VcRtMOeOnOOn3Zne88WF3PHLg9HdcWwDB8EHoLQigEfIHmvt8EaS4/2B/vpVY84vw
 1FSPfGVjQKnJmOefFf5y33rddQPQxvUCWV0rOwZgVjvHT5KVfhODXAkj6utjBOumJqH0wgT
 O45n8UZaZsnsgkl+9kYtw==
X-UI-Out-Filterresults: notjunk:1;V01:K0:J64+OGlZwDE=:kMT5Srrt5q4ueC5Qo8Dkux
 26XJXnx3Y9tH2ibddQN8ml8MafwPdf6dEWghBuR7CMtXH/TAx/DBiHHJSp3DJFOpoe96sPb4C
 4HDxSUOvx6NW8Zz2fu1R6iFqXEe86wnEIL1+fJVCdQKW0rJz9ogDw0cWM1v/16AxO4B/sPxK/
 fMDMJqMDpAUy+QEj47qRTG0eh3its+9VceVjFTcr24JIn+q6b0SRT+0ksTEGfUVDtWcV1BdJ+
 FxrCtGRDsUB07CBdWBdhDzNIRfGf9adTaH6v0IyH1ZwRM1dZgAPpNnzf/wIFbsGqYjZ6qqw7L
 sNcLPqUn2emegQUOxM831d9XL99xsVNnvTa/8PtKjY+fWErklbaT5kcLE6yU/R2THsRet5PcC
 I5c9pXQx36mAIQl3GGDr7qB7qT95mbsqwk7Mx85GHXK7uGemrbxtxg4EbK7QcR1lkjkN2fxS9
 7/Bg10UB4IcixEUsOjY/ETNktmkEqFFXkeZLmqLwu20C+ZZyvwxnhM/gF/YdrHsF69TojKlCB
 bKOM5lfTKisXpb0mqIZxvcSFGB3ZuPPDsz0lxHBbBomweg5m/9KdmI1+pPJg3l3GqQ77ycD3A
 VZPjp85fgHyopWLWm1nEFZfCHCgT1oslAUk/zj4BNlrKty3OukME5+NAELvMS/os3qShajeYC
 /uVRU/Tk4DgrgficlwSkgIgP3pciAUR5LPuZ3AFrbKLqSFa5I4ztn7Mx2zidvSPEHp6Aa+4Sr
 jzcJCbXtU36zXkbSFHk0GW+2nG5KEeGZ3ouoQWz1vG7f1VwUFjsWa50RSflnNh5BQzvbkvcb 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/296593>

On 06/06/2016 09:35 PM, Stefan Beller wrote:
> On Mon, Jun 6, 2016 at 12:17 PM, Torsten B=C3=B6gershausen <tboegi@we=
b.de> wrote:
>
>> A limitation is introduced by Mac OS and Windows:
>> BRANCH/NAME and branch/name refer to the same object in the file
>> system.
>> As a workaround, you can pack the branch names:
>> git pack-refs --all
>
> Once you packed a branch into the packed refs file, you can
> create another loose branch of different capitalization,
> which then 'hides' the packed ref?
>
> That sounds error prone to me, as a seemingly unrelated branch
> changed its value:
>
>      git branch BRANCH 012345
>      git pack-refs --all
>      git branch branch BRANCH^
>      git rev-parse BRANCH
>      (I'd expect BRANCH^ as return)
>
> (I don't have a windows machine for testing here, so that
> is pure speculation)
>
Yes, another reason not to use branch and BRANCH in the same repo.
(You can test under Linux & vfat)
