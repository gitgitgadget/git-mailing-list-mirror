From: Tim Mazid <timmazid@hotmail.com>
Subject: RE: FEATURE REQUEST: Cherry pick in not checked out branch
Date: Mon, 15 Mar 2010 20:54:32 +1100
Message-ID: <SNT124-W1769013489F8B7CE42C581C42E0@phx.gbl>
References: <be8f531d1003150139p7cc99700m807ab21bddf8fbb@mail.gmail.com>,<fabb9a1e1003150243o21bab937y122ac61d65777d5f@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
To: Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Mon Mar 15 10:54:39 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Nr70Q-0002cB-Se
	for gcvg-git-2@lo.gmane.org; Mon, 15 Mar 2010 10:54:39 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S936056Ab0COJyd (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 15 Mar 2010 05:54:33 -0400
Received: from snt0-omc3-s11.snt0.hotmail.com ([65.55.90.150]:20116 "EHLO
	snt0-omc3-s11.snt0.hotmail.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S935701Ab0COJyd convert rfc822-to-8bit
	(ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 15 Mar 2010 05:54:33 -0400
Received: from SNT124-W17 ([65.55.90.135]) by snt0-omc3-s11.snt0.hotmail.com with Microsoft SMTPSVC(6.0.3790.3959);
	 Mon, 15 Mar 2010 02:54:32 -0700
X-Originating-IP: [60.241.190.75]
Importance: Normal
In-Reply-To: <fabb9a1e1003150243o21bab937y122ac61d65777d5f@mail.gmail.com>
X-OriginalArrivalTime: 15 Mar 2010 09:54:32.0653 (UTC) FILETIME=[83249FD0:01CAC425]
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/142200>


Hi,
 
Could we not make cherry-pick "stash, checkout, cherry-pick, checkout, pop"?
 
Cheers,
Tim.
----------------------------------------
> From: srabbelier@gmail.com
> Date: Mon, 15 Mar 2010 10:43:14 +0100
> Subject: Re: FEATURE REQUEST: Cherry pick in not checked out branch
> To: zerthurd@gmail.com
> CC: git@vger.kernel.org
>
> Heya,
>
> On Mon, Mar 15, 2010 at 09:39, Maxim Treskin  wrote:
>> git cherry-pick applies the change introduced by specified commit only
>> to currently checked out branch. Why this requirement exists? Is it
>> possible to apply changes to not checked out branch, like:
>
> Because you need a working directory to resolve conflicts.
>
> --
> Cheers,
>
> Sverre Rabbelier
> --
> To unsubscribe from this list: send the line "unsubscribe git" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at http://vger.kernel.org/majordomo-info.html
 		 	   		  
_________________________________________________________________
Looking for a new home? With all the latest places, searching has never been easier.
http://clk.atdmt.com/NMN/go/157631292/direct/01/