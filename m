From: "Kevin P. Fleming" <kpfleming@digium.com>
Subject: Re: [PATCH] post-receive-email: remove spurious commas in email subject.
Date: Tue, 03 Aug 2010 08:50:16 -0500
Organization: Digium, Inc.
Message-ID: <4C581E98.6090504@digium.com>
References: <1280841049-19091-1-git-send-email-Matthieu.Moy@imag.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Matthieu Moy <Matthieu.Moy@imag.fr>
X-From: git-owner@vger.kernel.org Tue Aug 03 15:50:26 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OgHsw-00035L-32
	for gcvg-git-2@lo.gmane.org; Tue, 03 Aug 2010 15:50:26 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756663Ab0HCNuV (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 3 Aug 2010 09:50:21 -0400
Received: from mail.digium.com ([216.207.245.2]:52279 "EHLO mail.digium.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751453Ab0HCNuT (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 3 Aug 2010 09:50:19 -0400
Received: from zimbra.digium.internal ([10.24.55.203] helo=zimbra.hsv.digium.com)
	by mail.digium.com with esmtp (Exim 4.69)
	(envelope-from <kpfleming@digium.com>)
	id 1OgHsn-0002Il-PQ; Tue, 03 Aug 2010 08:50:17 -0500
Received: from localhost (localhost.localdomain [127.0.0.1])
	by zimbra.hsv.digium.com (Postfix) with ESMTP id B2966D8025;
	Tue,  3 Aug 2010 08:50:17 -0500 (CDT)
Received: from zimbra.hsv.digium.com ([127.0.0.1])
	by localhost (zimbra.hsv.digium.com [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id VtaTTK63gwXi; Tue,  3 Aug 2010 08:50:17 -0500 (CDT)
Received: from [172.19.1.105] (173-24-201-108.client.mchsi.com [173.24.201.108])
	by zimbra.hsv.digium.com (Postfix) with ESMTPSA id 24FA5D8023;
	Tue,  3 Aug 2010 08:50:17 -0500 (CDT)
User-Agent: Mozilla/5.0 (X11; U; Linux x86_64; en-US; rv:1.9.1.11) Gecko/20100713 Thunderbird/3.0.6
In-Reply-To: <1280841049-19091-1-git-send-email-Matthieu.Moy@imag.fr>
X-Enigmail-Version: 1.0.1
OpenPGP: id=05FB8DB2
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/152521>

On 08/03/2010 08:10 AM, Matthieu Moy wrote:
> The previous form produced subjects like
> 
>   [SCM] project.git branch, foo, updated. ...
> 
> The new one will produce the lighter
> 
>   [SCM] project.git branch foo updated. ...
> 
> Signed-off-by: Matthieu Moy <Matthieu.Moy@imag.fr>
> ---
> I am the only one bothered by these extra commas in email subject? If
> so, I can live with it, but I thought I'd give it a try ;-).

No, I've removed them in our local copy as well, but never bothered to
send the changes to the list :-)

-- 
Kevin P. Fleming
Digium, Inc. | Director of Software Technologies
445 Jan Davis Drive NW - Huntsville, AL 35806 - USA
skype: kpfleming | jabber: kfleming@digium.com
Check us out at www.digium.com & www.asterisk.org
