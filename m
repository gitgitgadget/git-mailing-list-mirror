From: Andy Parkins <andyp@fussylogic.co.uk>
Subject: Re: Fwd: Re: [git-multimail] License unknown (#1)
Date: Tue, 12 Feb 2013 15:11:36 +0000
Message-ID: <201302121511.36316.andyp@fussylogic.co.uk>
References: <5105778A.1040401@alum.mit.edu> <511A04DA.7010809@alum.mit.edu>
Mime-Version: 1.0
Content-Type: Text/Plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Michael Haggerty <mhagger@alum.mit.edu>
X-From: git-owner@vger.kernel.org Tue Feb 12 16:18:19 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1U5Hcg-0004DT-FH
	for gcvg-git-2@plane.gmane.org; Tue, 12 Feb 2013 16:18:18 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1761355Ab3BLPR5 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 12 Feb 2013 10:17:57 -0500
Received: from smtpout.karoo.kcom.com ([212.50.160.34]:58269 "EHLO
	smtpout.karoo.kcom.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1761312Ab3BLPRy (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 12 Feb 2013 10:17:54 -0500
X-Greylist: delayed 376 seconds by postgrey-1.27 at vger.kernel.org; Tue, 12 Feb 2013 10:17:54 EST
X-IronPort-AV: E=Sophos;i="4.84,650,1355097600"; 
   d="scan'208";a="530991"
Received: from unknown (HELO momentum.parkins.org.uk) ([91.84.15.31])
  by smtpout.karoo.kcom.com with ESMTP; 12 Feb 2013 15:11:36 +0000
Received: from localhost ([127.0.0.1] helo=momentum.localnet)
	by momentum.parkins.org.uk with esmtp (Exim 4.80)
	(envelope-from <andyp@fussylogic.co.uk>)
	id 1U5HWC-0005EJ-OF; Tue, 12 Feb 2013 15:11:36 +0000
User-Agent: KMail/1.13.7 (Linux/3.2.0-3-686-pae; KDE/4.8.4; i686; ; )
In-Reply-To: <511A04DA.7010809@alum.mit.edu>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/216158>

On Tuesday 12 February 2013 09:01:14 Michael Haggerty wrote:

> I assume you are the Andy Parkins who originally submitted
> post-commit-email to the Git project...

I am indeed.  Hello.

> I have derived another script from yours:
> 
>     https://github.com/mhagger/git-multimail
> 
> I affixed the GPLv2 boilerplate to the code under the assumption that it
> inherited this license from the Git project.  But afterwards I realized
> that I am not entirely confident that the GPLv2 applies to
> post-commit-email.

I'm sorry, that's entirely my fault.  I had read somewhere in the git 
submission policy that everything submitted was naturally under the same 
license as git itself.
 
> Obviously the situation is even more complicated because other people
> have contributed patches to the script since your original submission.
> But it would nevertheless be very helpful if you would clarify your
> original intention, *especially* if your intention was to put the script
> under a license different than GPLv2.

My intention was to put my code under exactly the license the git itself is 
under.  I am delighted for you or anyone else to use or derive from it.

I'm also sorry I didn't respond to your first email, it accidentally got 
sorted into spam.

If anyone wants some sort of legal declaration, I'm happy to give it.

> -------- Original Message --------
> Subject: Re: [git-multimail] License unknown (#1)
> Date: Sun, 27 Jan 2013 19:52:58 +0100
> From: Michael Haggerty <mhagger@alum.mit.edu>
> To: git discussion list <git@vger.kernel.org>,  Andy Parkins
> <andyparkins@gmail.com>
> CC: mhagger/git-multimail
> <reply+i-10159725-60cb2c338c594bd09d77fe2f8d628aa55114a3f6-119718@reply.git
> hub.com>, Michiel Holtkamp <notifications@github.com>
> 
> I have a question about the license of contrib/hooks/post-commit-email.
>  I had assumed that since it is in the git project, which is GPLv2, and
> since it contains no contrary information, it would by implication also
> fall under GPLv2.  But the file itself contains no explicit license
> information, and it is not clear to me that the "signed-off-by" line
> implies a particular license, either.  (The signed-off-by *does* seem to
> imply that the source code is under some kind of open source license,
> but not which one.)
> 
> If somebody can explain what license the code is under and how they come
> to that conclusion, I would be very grateful.
> 
> And if Andy Parkins (the original author) is listening, please indicate
> whether you had any intent *other* than GPLv2.
> 
> For anybody who is interested, the file was first committed in
> 4557e0de5b and has been modified by several authors since then.
> 
> Given the pretty clear open-sourciness of the script, I don't think this
> has to be made into a big issue.  But it would be nice to state the
> license explicitly for future users' information.
> 
> Thanks,
> Michael
> 
> On 01/27/2013 02:38 PM, Michiel Holtkamp wrote:
> > Actually, I'm not sure that it is GPLv2 for the original script. The
> > COPYING file in the main project declares the project as GPLv2, but it
> > also says that people contributing should make their preferences (for
> > licensing) known. Maybe we can assume it's GPLv2, (as the original
> > writer might have assumed it was GPLv2), but it's not explicitly stated
> > so I'm not sure (IANAL).

-- 
Dr Andy Parkins
Director
FussyLogic Ltd

tel:  0845 557 7645

web:  www.fussylogic.co.uk

Company Registration No. 8198285      Registered in England and Wales

  This email and any attachments to it may be confidential and are
  intended solely for the use of the individual to whom it is addressed.
  Any views or opinions expressed are solely those of the author and do
  not necessarily represent those of FussyLogic Ltd.

  If you are not the intended recipient of this email, you must neither
  take any action based upon its contents, nor copy or show it to
  anyone.
  
  Please contact the sender if you believe you have received this email
  in error.
