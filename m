From: Jens Lehmann <Jens.Lehmann@web.de>
Subject: Re: gitk with submodules does not show new commits on other branches
Date: Mon, 23 Jun 2014 18:31:21 +0200
Message-ID: <53A85659.2040905@web.de>
References: <lo6o2h$vva$1@ger.gmane.org> <53A6F978.4010005@web.de> <lo6tnh$p3c$1@ger.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
To: Stephen Kelly <steveire@gmail.com>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Jun 23 18:31:40 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Wz79X-0001O0-KL
	for gcvg-git-2@plane.gmane.org; Mon, 23 Jun 2014 18:31:31 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756112AbaFWQb1 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 23 Jun 2014 12:31:27 -0400
Received: from mout.web.de ([212.227.15.14]:58789 "EHLO mout.web.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755721AbaFWQb1 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 23 Jun 2014 12:31:27 -0400
Received: from [192.168.178.41] ([84.132.189.37]) by smtp.web.de (mrweb003)
 with ESMTPSA (Nemesis) id 0MXYTG-1XDuBP1u2Y-00WYbW; Mon, 23 Jun 2014 18:31:25
 +0200
User-Agent: Mozilla/5.0 (X11; Linux i686 on x86_64; rv:24.0) Gecko/20100101 Thunderbird/24.6.0
In-Reply-To: <lo6tnh$p3c$1@ger.gmane.org>
X-Enigmail-Version: 1.6
X-Provags-ID: V03:K0:nDblgtxXSfFiisVRZS9P98u6v6gU8ZJAYYSdBKlTMQJ0Bab6aQ+
 QgYXQSVMfpjB+frkt0l/SeXY7sf8/TE4YOaMFrGdIMGZs6JFJe/qzgTMMEXY628799btV9z
 lMMrCUYtmjJHffEqmjaQAoKjOl+hPyVKFPHlONbPewH4vbb8jVH5ZU5tmhwic0DXcjcYUmm
 PD3LgxxR6reSXmzcBrEgA==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/252350>

Am 22.06.2014 17:45, schrieb Stephen Kelly:
> Jens Lehmann wrote:
> 
>> Am 22.06.2014 16:09, schrieb Stephen Kelly:
>> But I agree that this is suboptimal for your workflow. What about adding
>> a "Visualize These Changes In The Submodule" menu entry for the context
>> menu of a change in gitk just like the one git gui already has?
> 
> Can you tell me how to find and try that out in git gui?

Sure, you'll find that in the pop-up menu when right clicking the
submodule summary in the diff pane (where you can choose to stage
or unstage hunks or lines for regular files).
