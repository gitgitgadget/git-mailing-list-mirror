From: Drew Northup <drew.northup@maine.edu>
Subject: Re: [PATCH 03/10] Change remote tracking to remote-tracking in
	non-trivial places
Date: Fri, 29 Oct 2010 13:26:46 -0400
Message-ID: <1288373206.5748.16.camel@drew-northup.unet.maine.edu>
References: <1287851481-27952-1-git-send-email-Matthieu.Moy@imag.fr>
	 <1288290117-6734-4-git-send-email-Matthieu.Moy@imag.fr>
	 <20101028183919.GD14212@burratino> <vpq4oc6f0ms.fsf@bauges.imag.fr>
	 <20101028221316.GD16125@burratino>  <vpqk4l2djqc.fsf@bauges.imag.fr>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Cc: Jonathan Nieder <jrnieder@gmail.com>, git@vger.kernel.org,
	gitster@pobox.com, Thore Husfeldt <thore.husfeldt@gmail.com>,
	Jakub Narebski <jnareb@gmail.com>
To: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
X-From: git-owner@vger.kernel.org Fri Oct 29 19:28:53 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PBsl2-0003u3-NJ
	for gcvg-git-2@lo.gmane.org; Fri, 29 Oct 2010 19:28:53 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S934200Ab0J2R2q (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 29 Oct 2010 13:28:46 -0400
Received: from beryl.its.maine.edu ([130.111.32.94]:39163 "EHLO
	beryl.its.maine.edu" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753102Ab0J2R2U (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 29 Oct 2010 13:28:20 -0400
Received: from [IPv6:2610:48:100:827:211:43ff:fe9f:cb7e] (drew-northup.unet.maine.edu [IPv6:2610:48:100:827:211:43ff:fe9f:cb7e])
	by beryl.its.maine.edu (8.13.8/8.13.8) with ESMTP id o9THQplr015596
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NOT);
	Fri, 29 Oct 2010 13:26:51 -0400
In-Reply-To: <vpqk4l2djqc.fsf@bauges.imag.fr>
X-Mailer: Evolution 2.12.3 (2.12.3-8.el5_2.3) 
X-DCC-UniversityOfMaineSystem-Metrics: beryl.its.maine.edu 1003; Body=6 Fuz1=6
	Fuz2=6
X-MailScanner-Information: Please contact the ISP for more information
X-UmaineSystem-MailScanner-ID: o9THQplr015596
X-MailScanner: Found to be clean
X-MailScanner-From: drew.northup@maine.edu
X-UmaineSystem-MailScanner-Watermark: 1288978017.05159@uSQlPjRlT1+4Zybis6Feog
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/160346>


On Fri, 2010-10-29 at 00:40 +0200, Matthieu Moy wrote:
> Jonathan Nieder <jrnieder@gmail.com> writes:
> 
> > Matthieu Moy wrote:
> >
> >> What I'm trying to do here is really to achieve consistancy. If
> >> something has a name, let's use the same name everywhere.
> >
> > Okay, but can it at least not be part of a patch that does something
> > simpler (only adding dashes)?
> 
> OK, I'll do that.
> 
> > I'm not sure why you don't like the idea of rewording it, but
> > that's fine ---
> 
> Not that I don't like the idea. I'm just saying that my patch makes
> the situation better that it used to. No objection if other people
> want to make it even better later (but I probably won't have time
> soon).

I was contemplating taking some time to look more closely at this
document myself. This patch does not get in the way of my doing so.

-- 
-Drew Northup N1XIM
   AKA RvnPhnx on OPN
________________________________________________
"As opposed to vegetable or mineral error?"
-John Pescatore, SANS NewsBites Vol. 12 Num. 59
