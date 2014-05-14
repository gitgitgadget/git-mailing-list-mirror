From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: Re: [PATCH] contrib: remote-helpers: add move warnings (v2.0)
Date: Wed, 14 May 2014 14:39:18 -0500
Message-ID: <5373c6668871b_56d6e3b30451@nysa.notmuch>
References: <1400016596-13178-1-git-send-email-felipe.contreras@gmail.com>
 <xmqq7g5pmj5r.fsf@gitster.dls.corp.google.com>
 <53729b2150a84_34aa9e5304e0@nysa.notmuch>
 <xmqq38gdmhdo.fsf@gitster.dls.corp.google.com>
 <5372a0f6650d2_36c411ff3002e@nysa.notmuch>
 <5372D205.4040004@gmail.com>
 <xmqqppjgji2s.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 7bit
Cc: Felipe Contreras <felipe.contreras@gmail.com>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>,
	Marius Storm-Olsen <mstormo@gmail.com>
X-From: git-owner@vger.kernel.org Wed May 14 21:50:28 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WkfC2-0005QN-IU
	for gcvg-git-2@plane.gmane.org; Wed, 14 May 2014 21:50:22 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751425AbaENTuR (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 14 May 2014 15:50:17 -0400
Received: from mail-ob0-f172.google.com ([209.85.214.172]:37061 "EHLO
	mail-ob0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751118AbaENTuQ (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 14 May 2014 15:50:16 -0400
Received: by mail-ob0-f172.google.com with SMTP id wp18so57497obc.3
        for <git@vger.kernel.org>; Wed, 14 May 2014 12:50:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=date:from:to:cc:message-id:in-reply-to:references:subject
         :mime-version:content-type:content-transfer-encoding;
        bh=7yzZAdx5ZmOjpzBrEP4B8Umk3PakYt5KPxnLGIeUsys=;
        b=mQ6FyWkcw1GjhRgLNUvgrG0b2SsxwbyhAcZ3hzjy/UCSzdavw63hb8C4lC9YRm4M2n
         zd0n4Momr65E7XhR7DVpZcj0wFXINGI5V5Mvu7g84TtRXjSZEKJm8aJhTUnD1g0mG95w
         QUISv9x544T64EmzzYVp47ON7T3FSnINFmxe1e+b9deNRKRjnDRIMmT6sz3SQTffwlOd
         UUkbB0paTPcI2PzZECOpRIYpipP16Pg1KUIeY6yCSOadlNIeml+pB5bgDwz63EIK+N/E
         XJSWdldwYgrR5xATu+qz9fCrMeEsiBJQiceIqC5MdJlpYkR5u6UZIg6H+W8rrqSKodM9
         m1AQ==
X-Received: by 10.60.93.168 with SMTP id cv8mr5602226oeb.21.1400097015735;
        Wed, 14 May 2014 12:50:15 -0700 (PDT)
Received: from localhost (189-211-224-40.static.axtel.net. [189.211.224.40])
        by mx.google.com with ESMTPSA id ld8sm4909518obb.9.2014.05.14.12.50.14
        for <multiple recipients>
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 14 May 2014 12:50:15 -0700 (PDT)
In-Reply-To: <xmqqppjgji2s.fsf@gitster.dls.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/248944>

Junio C Hamano wrote:
> So at this point, I would have to say that the users of remote-hg is
> taken hostage by its author.

The users of remote-hg are being affected negatively *because* of your
decisions.

You have the power to help them by answering a simple question. Yet you
refuse to do that.

It's all on you.

-- 
Felipe Contreras
