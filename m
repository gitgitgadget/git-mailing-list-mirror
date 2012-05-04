From: Andrew Sayers <andrew-20120504@pileofstuff.org>
Subject: Re: Newbie grief
Date: Fri, 04 May 2012 20:18:20 +0100
Message-ID: <4FA42B7C.4010202@pileofstuff.org>
References: <4F9F128C.5020304@palm.com>	<201204302331.q3UNVo7o032303@no.baka.org>	<4F9F28F5.2020403@palm.com>	<201205010137.q411bxaU002449@no.baka.org>	<4F9F52B9.9060508@palm.com>	<08704bd2e32343a4b9def80e4fa1efa2-mfwitten@gmail.com>	<4FA2D8EA.7030809@palm.com>	<87obq5ggpu.fsf@an-dro.info.enstb.org>	<7vehr1dl2z.fsf@alter.siamese.dyndns.org>	<4FA307C5.102@palm.com>	<4FA3090D.5080406@palm.com>	<4FA32A6A.4070007@blizzard.com> <CA+7g9Jxp859st6SrViizwOMrU9vsnmfy6P64SK9y_-ZEzEB6Mw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: Illia Bobyr <ibobyr@blizzard.com>,
	Rich Pixley <rich.pixley@palm.com>,
	Ronan Keryell <Ronan.Keryell@hpc-project.com>,
	"git@vger.kernel.org" <git@vger.kernel.org>
To: Nathan Gray <n8gray@n8gray.org>
X-From: git-owner@vger.kernel.org Fri May 04 21:18:32 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SQO1N-0006wR-Sw
	for gcvg-git-2@plane.gmane.org; Fri, 04 May 2012 21:18:30 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759390Ab2EDTSZ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 4 May 2012 15:18:25 -0400
Received: from mtaout01-winn.ispmail.ntl.com ([81.103.221.47]:57237 "EHLO
	mtaout01-winn.ispmail.ntl.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1754097Ab2EDTSY (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 4 May 2012 15:18:24 -0400
Received: from aamtaout03-winn.ispmail.ntl.com ([81.103.221.35])
          by mtaout01-winn.ispmail.ntl.com
          (InterMail vM.7.08.04.00 201-2186-134-20080326) with ESMTP
          id <20120504191823.KJTT10903.mtaout01-winn.ispmail.ntl.com@aamtaout03-winn.ispmail.ntl.com>;
          Fri, 4 May 2012 20:18:23 +0100
Received: from [192.168.0.3] (really [94.170.150.126])
          by aamtaout03-winn.ispmail.ntl.com
          (InterMail vG.3.00.04.00 201-2196-133-20080908) with ESMTP
          id <20120504191823.TUHB13318.aamtaout03-winn.ispmail.ntl.com@[192.168.0.3]>;
          Fri, 4 May 2012 20:18:23 +0100
User-Agent: Mozilla/5.0 (X11; U; Linux x86_64; en-US; rv:1.9.2.28) Gecko/20120313 Thunderbird/3.1.20
In-Reply-To: <CA+7g9Jxp859st6SrViizwOMrU9vsnmfy6P64SK9y_-ZEzEB6Mw@mail.gmail.com>
X-Cloudmark-Analysis: v=1.1 cv=JvdXmxIgLJv2/GthKqHpGJEEHukvLcvELVXUanXFreg= c=1 sm=0 a=yXtjXN6ItgYA:10 a=u4BGzq-dJbcA:10 a=8nJEP1OIZ-IA:10 a=Fpnz726e6VfeEiT13WsA:9 a=wPNLvfGTeEIA:10 a=HpAAvcLHHh0Zw7uRqdWCyQ==:117
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/197053>

On 04/05/12 04:13, Nathan Gray wrote:
> I just led a team of reasonably bright people through a transition
> from SVN to git.  Not one of them understood this message.  Every one
> of them thought something was broken.  This is a very common
> occurrence, so a short, simple message without jargon for this error
> would be a big, big win.

Now you come to mention it, I had the same experience a while back.

The message could certainly do with improvement, but I think this
particular case is more a side-effect of the push.default issue
currently being worked through.  Beginners expect `git push` to push a
single branch, so they see "error" and assume the single branch they
pushed must have failed.

	- Andrew
