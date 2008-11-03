From: Pete Harlan <pgit@pcharlan.com>
Subject: Re: [PATCH] contrib/hooks/post-receive-email: Make revision display
 configurable
Date: Mon, 03 Nov 2008 01:49:52 -0800
Message-ID: <490EC940.4010803@pcharlan.com>
References: <1225668059-12670-1-git-send-email-pgit@pcharlan.com> <490E36C0.5040701@pcharlan.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
To: Andy Parkins <andyparkins@gmail.com>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Nov 03 10:51:27 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Kww5k-0007Ou-Ua
	for gcvg-git-2@gmane.org; Mon, 03 Nov 2008 10:51:25 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754691AbYKCJuL (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 3 Nov 2008 04:50:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754664AbYKCJuL
	(ORCPT <rfc822;git-outgoing>); Mon, 3 Nov 2008 04:50:11 -0500
Received: from lax-green-bigip-5.dreamhost.com ([208.113.200.5]:55781 "EHLO
	swarthymail-a1.g.dreamhost.com" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S1754652AbYKCJuK (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 3 Nov 2008 04:50:10 -0500
Received: from [192.168.0.101] (031.132-78-65.ftth.swbr.surewest.net [65.78.132.31])
	by swarthymail-a1.g.dreamhost.com (Postfix) with ESMTP id 32C968F415;
	Mon,  3 Nov 2008 01:49:52 -0800 (PST)
User-Agent: Thunderbird 2.0.0.17 (X11/20080925)
In-Reply-To: <490E36C0.5040701@pcharlan.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/99924>

Pete Harlan wrote:
> Sorry for the repeat emails....this first-time "git send-email" user was
> a little surprised that it appears to always cc git@vger...

No, Pete, it only cc'd the "Signed-of-by:" address, which you filtered
to your git-list mailbox.

Sorry for this noise.  I'll get the hang of things sooner or later.

If you think the patch, or the idea, could be worth applying in some
form, I'd appreciate any feedback.

Thanks,

--Pete

> 
> <hides behind rock>
> 
> --Pete
> 
> Pete Harlan wrote:
>> Add configuration option hooks.showrev, letting the user override how
>> revisions will be shown in the commit email.
> 
> --
> To unsubscribe from this list: send the line "unsubscribe git" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
