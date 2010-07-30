From: Stephen Boyd <bebarino@gmail.com>
Subject: Re: [PATCH] bash-completion: Print a useful error when called in
 a non-bash shell
Date: Thu, 29 Jul 2010 23:02:25 -0700
Message-ID: <4C526AF1.8000309@gmail.com>
References: <4C50B005.1030004@pileofstuff.org> <7v4ofiuuf7.fsf@alter.siamese.dyndns.org> <4C51F2C0.8090101@pileofstuff.org> <7vr5ilsvtf.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: Andrew Sayers <andrew-git@pileofstuff.org>,
	Git Mailing List <git@vger.kernel.org>,
	solsTiCe d'Hiver <solstice.dhiver@gmail.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Jul 30 08:02:56 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OeigG-0002Yd-2C
	for gcvg-git-2@lo.gmane.org; Fri, 30 Jul 2010 08:02:52 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754775Ab0G3GCk (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 30 Jul 2010 02:02:40 -0400
Received: from mail-pw0-f46.google.com ([209.85.160.46]:37941 "EHLO
	mail-pw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754726Ab0G3GCj (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 30 Jul 2010 02:02:39 -0400
Received: by pwi5 with SMTP id 5so394729pwi.19
        for <git@vger.kernel.org>; Thu, 29 Jul 2010 23:02:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from
         :user-agent:mime-version:to:cc:subject:references:in-reply-to
         :content-type:content-transfer-encoding;
        bh=ChG2K+zLaEy78TTCbbvUxdeRV/CSGkznFOfFcM945Dc=;
        b=xomgm9WY9TvGU1gIKYfznP59OwHZAHKr78/MocRQuFRb/8HZdn0qgXmwqktxnc0f4l
         Q10vYtiEMrZAQEu3zYQplv/x0u3VnRCblHjjay4iwrYNbR5qSfI0KpHM2InMiS9znlrl
         LiqmC9bW7SIVt1+wlAmZOvLcIxioiVYNSo3Xg=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:user-agent:mime-version:to:cc:subject
         :references:in-reply-to:content-type:content-transfer-encoding;
        b=n3jjGMoqlCm8/nxkDBkPy568ho3EXAZ/hhhsWf8yz+lzZBAFVyDRUHXUNZJiGDGFna
         0XNjPRWyc4YdSJjF57CajuRgAwSj3oBNRfvuNGqrqYbPbKQ7pE8+JZzu0/pdgGpLJezc
         RaiDovI8GoneHatZsS3RC2j6kBLeWDIZwx7v4=
Received: by 10.114.46.20 with SMTP id t20mr1587293wat.181.1280469759304;
        Thu, 29 Jul 2010 23:02:39 -0700 (PDT)
Received: from [192.168.1.101] ([75.85.182.25])
        by mx.google.com with ESMTPS id k23sm3018667waf.17.2010.07.29.23.02.34
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Thu, 29 Jul 2010 23:02:38 -0700 (PDT)
User-Agent: Mozilla/5.0 (X11; U; Linux x86_64; en-US; rv:1.9.2.4) Gecko/20100713 Thunderbird/3.1
In-Reply-To: <7vr5ilsvtf.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/152220>

  On 07/29/2010 04:38 PM, Junio C Hamano wrote:
>
> +Reporting Bugs
> +--------------
> +
> +If you found a bug, please send a bug report to the Git mailing list
> +<git@vger.kernel.org>, where the development and maintenance is primarily
> +done.  You do not have to be subscribed to the list to send a message
> +there.
> +

I like it. How do I know if I found a bug though? Probably better to just say:

	Report bugs to the Git mailing list<git@vger.kernel.org>
	where development and ...
