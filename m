From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: [PATCHv7.4 0/4] Gitweb caching v7.2
Date: Fri, 3 Dec 2010 20:30:22 +0100
Message-ID: <201012032030.24639.jnareb@gmail.com>
References: <1291404335-25541-1-git-send-email-jnareb@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-2"
Content-Transfer-Encoding: 7bit
Cc: John 'Warthog9' Hawley <warthog9@kernel.org>,
	John 'Warthog9' Hawley <warthog9@eaglescrag.net>,
	Junio C Hamano <gitster@pobox.com>,
	Thomas Rast <trast@student.ethz.ch>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Dec 03 20:30:43 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PObL8-0004Ov-LK
	for gcvg-git-2@lo.gmane.org; Fri, 03 Dec 2010 20:30:43 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752483Ab0LCTag (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 3 Dec 2010 14:30:36 -0500
Received: from mail-bw0-f46.google.com ([209.85.214.46]:48821 "EHLO
	mail-bw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752481Ab0LCTaf (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 3 Dec 2010 14:30:35 -0500
Received: by bwz15 with SMTP id 15so8660483bwz.19
        for <git@vger.kernel.org>; Fri, 03 Dec 2010 11:30:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:subject:date
         :user-agent:cc:references:in-reply-to:mime-version:content-type
         :content-transfer-encoding:content-disposition:message-id;
        bh=DmUqUsPzqsAkeP3hOPM8Qj4qzzfxy1qfFRFk2a9gR8M=;
        b=aTy9A3X10ltRxwWNYLMdz+wgcW1mwwRslVUZa4TSh9q9ZMh+VN8rNjNp0EMCUIKNY2
         rhNNWXKbyxw0RAJv+GrYG68J7c9C4Wc6wYRiyUhnG+kuTPBHsZlnBX6pHSxucYAbTJmg
         j0+ZxqqOCGxEDP/9aHnRtVMRJQPgrsuIswcbQ=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:subject:date:user-agent:cc:references:in-reply-to
         :mime-version:content-type:content-transfer-encoding
         :content-disposition:message-id;
        b=LUJEmf3eThjPs2uH2yDNHGr09+rvnabYTkZgM4LgLcQIICYezMYetPFeOYNG3ssYum
         UMjhklq8Bzjwq4S2MqyVVnIu9knLlrferp9O8LXED+62l11e2rl/737ODHfvB49raUqO
         NM82NdRjHj+SiIqY5NW6Q67LpbHGuvUvaHcjs=
Received: by 10.204.68.142 with SMTP id v14mr3007224bki.106.1291404634386;
        Fri, 03 Dec 2010 11:30:34 -0800 (PST)
Received: from [192.168.1.13] (abrz239.neoplus.adsl.tpnet.pl [83.8.119.239])
        by mx.google.com with ESMTPS id q18sm111726bka.3.2010.12.03.11.30.31
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Fri, 03 Dec 2010 11:30:32 -0800 (PST)
User-Agent: KMail/1.9.3
In-Reply-To: <1291404335-25541-1-git-send-email-jnareb@gmail.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/162836>

Sorry, of course subject should read:

  [PATCHv7.4 0/4] Gitweb caching v7.4

-- 
Jakub Narebski
Poland
