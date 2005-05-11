From: Alexey Nezhdanov <snake@penza-gsm.ru>
Subject: Re: GIT compile error on Sun Sparc SB2000
Date: Wed, 11 May 2005 17:01:25 +0400
Message-ID: <200505111701.26303.snake@penza-gsm.ru>
References: <200505111141.27725.snake@penza-gsm.ru> <1115809273.16187.493.camel@hades.cambridge.redhat.com> <200505111657.14424.snake@penza-gsm.ru>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="koi8-r"
Content-Transfer-Encoding: 7bit
X-From: git-owner@vger.kernel.org Wed May 11 14:54:13 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DVqir-0002O0-RX
	for gcvg-git@gmane.org; Wed, 11 May 2005 14:53:58 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261196AbVEKNBa (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 11 May 2005 09:01:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261215AbVEKNBa
	(ORCPT <rfc822;git-outgoing>); Wed, 11 May 2005 09:01:30 -0400
Received: from host-80-95-32-178.leasedlines.sura.ru ([80.95.32.178]:3302 "HELO
	penza-gsm.ru") by vger.kernel.org with SMTP id S261196AbVEKNB3
	(ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 11 May 2005 09:01:29 -0400
Received: (qmail 14811 invoked from network); 11 May 2005 13:01:27 -0000
Received: from unknown (HELO snake) (192.168.0.20)
  by fileserver.penza-gsm.ru with SMTP; 11 May 2005 13:01:26 -0000
To: git@vger.kernel.org
User-Agent: KMail/1.7.2
In-Reply-To: <200505111657.14424.snake@penza-gsm.ru>
Content-Disposition: inline
X-Spam-Checker-Version: SpamAssassin 3.0.2 (2004-11-16) on fileserver
X-Spam-Level: 
X-Spam-Status: No, score=-105.8 required=5.0 tests=ALL_TRUSTED,AWL,BAYES_00,
	USER_IN_WHITELIST autolearn=ham version=3.0.2
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

Wensday, 11 May 2005 16:57 Alexey Nezhdanov wrote:
> 64bits libz and libcurl are missing.
Just to be correct:
libssl and libcurl actually.
But this already makes no sense.

-- 
Respectfully
Alexey Nezhdanov

