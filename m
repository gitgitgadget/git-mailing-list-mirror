From: SungHyun Nam <goweol@gmail.com>
Subject: bash completion for 'git version'? (Re: git bundle bug?)
Date: Mon, 26 Jul 2010 16:29:51 +0900
Message-ID: <4C4D396F.5000006@gmail.com>
References: <i2jaue$f7a$1@dough.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: unlisted-recipients:; (no To-header on input)
X-From: git-owner@vger.kernel.org Mon Jul 26 09:30:09 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OdI8S-00005I-PL
	for gcvg-git-2@lo.gmane.org; Mon, 26 Jul 2010 09:30:05 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753819Ab0GZH35 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 26 Jul 2010 03:29:57 -0400
Received: from mail-px0-f174.google.com ([209.85.212.174]:44288 "EHLO
	mail-px0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753746Ab0GZH34 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 26 Jul 2010 03:29:56 -0400
Received: by pxi14 with SMTP id 14so4438553pxi.19
        for <git@vger.kernel.org>; Mon, 26 Jul 2010 00:29:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from
         :user-agent:mime-version:cc:subject:references:in-reply-to
         :content-type:content-transfer-encoding;
        bh=LPP5a0/0nlHwNasJNO5aRBvANrrn5vmNHYu6DEw+T50=;
        b=hTFsXACao/j+r+c8mfwiGnalBbpES30/68UZcRSoF03yuMhYcOqjzDm+VleoNdCTw7
         CLdOfqNyJssNFxAGEEUCfCtE2eB2EoyAYWQfP9K4qT3sgpBeDU3J8z00slp5zEi5OjPl
         1QyBs2+CBRgppA7vmquf0+RnXw5oNUNJe1CKY=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:user-agent:mime-version:cc:subject:references
         :in-reply-to:content-type:content-transfer-encoding;
        b=xljleG2F/9AXebYFDAr1pp/WcZIvFt2oCS1l9pSiELty5kroGqriRVgsguOnWb3jVH
         ZOPVSWFZ3cE7rpDzvC8cO2jlSRAD1svzTN9/48VB9e6k163LLVDmwotKgIoR0eKHWZau
         sokejnHjXcfbHnDSWRVnfLRdhds0lt8H3r0Gk=
Received: by 10.114.197.17 with SMTP id u17mr11063764waf.36.1280129395789;
        Mon, 26 Jul 2010 00:29:55 -0700 (PDT)
Received: from [210.181.13.12] ([210.181.13.12])
        by mx.google.com with ESMTPS id k23sm6114490waf.17.2010.07.26.00.29.54
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Mon, 26 Jul 2010 00:29:55 -0700 (PDT)
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.1; ko; rv:1.9.1.11) Gecko/20100711 Thunderbird/3.0.6
In-Reply-To: <i2jaue$f7a$1@dough.gmane.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/151814>

SungHyun Nam wrote:
 >
 > $ git version
 > git version 1.7.1.772.g64fdc

I prefer 'git version' instead of 'git --version'.
But 'git ver<tab>' does not expand, though the 'git --ver<tab>' does.

Regards,
namsh
