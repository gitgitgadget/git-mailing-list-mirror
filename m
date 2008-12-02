From: Liu Yubao <yubao.liu@gmail.com>
Subject: Re: [PATCH 0/5] support reading and writing uncompressed loose object
Date: Tue, 02 Dec 2008 11:11:59 +0800
Message-ID: <4934A77F.80900@gmail.com>
References: <493399B7.5000505@gmail.com> <7voczws3np.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <gitster@pobox.com>
To: git list <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Tue Dec 02 04:13:30 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1L7LhY-0004ia-DW
	for gcvg-git-2@gmane.org; Tue, 02 Dec 2008 04:13:28 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752657AbYLBDMK (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 1 Dec 2008 22:12:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752503AbYLBDMJ
	(ORCPT <rfc822;git-outgoing>); Mon, 1 Dec 2008 22:12:09 -0500
Received: from yw-out-2324.google.com ([74.125.46.31]:21293 "EHLO
	yw-out-2324.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751485AbYLBDMG (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 1 Dec 2008 22:12:06 -0500
Received: by yw-out-2324.google.com with SMTP id 9so1104903ywe.1
        for <git@vger.kernel.org>; Mon, 01 Dec 2008 19:12:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from
         :user-agent:mime-version:to:cc:subject:references:in-reply-to
         :content-type:content-transfer-encoding;
        bh=clvHX9CqHRIDWEb6RFtb2+YmkND+MTTalSkXzxsMpWI=;
        b=KPceKOjg/ini0IN3t73fswK2wnAxCQwSfC8jrG4WZDv524/Bjp7A6yXm20QrUGnMpf
         QXTjehMSbBJ09auGny5JumpEvz7idXeeb42ngPty+WspLMo+Ai48kt89XI43XCWn/eWn
         WAC0hMufH1n7KZRiD4yWAt+eqYWi8OQ7KxJmI=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:user-agent:mime-version:to:cc:subject
         :references:in-reply-to:content-type:content-transfer-encoding;
        b=Ec8y1BfNEijZdJjIGxqwNJ9EnWeDDjRPdTRluDdk+xZsbTyXuNJmk3UF57p3OGDQxy
         bR48yEXY8ae/5Ho+zS60Qf8g89kMuZ+owEex8zaz3tvPAL11PvS+rGxknrPyMnRi8DE3
         RYq323AGE52xODhY8cWbC3kud+qoB7JWsfSIU=
Received: by 10.142.12.14 with SMTP id 14mr4752092wfl.28.1228187524980;
        Mon, 01 Dec 2008 19:12:04 -0800 (PST)
Received: from ?10.64.1.142? ([211.157.41.194])
        by mx.google.com with ESMTPS id 30sm28955wfa.41.2008.12.01.19.12.02
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Mon, 01 Dec 2008 19:12:04 -0800 (PST)
User-Agent: Thunderbird 2.0.0.18 (Windows/20081105)
In-Reply-To: <7voczws3np.fsf@gitster.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/102118>

Hi all,

It seems my patch series are not in one mail thread, I'm very sorry
for that, I replied this thread and paste my patches into Thunderbird
with external editor plugin, don't know why they become separate topics.


Best regards,

Liu Yubao
