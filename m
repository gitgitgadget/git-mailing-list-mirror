From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v2] git-checkout.txt: Document "git checkout <pathspec>" better
Date: Wed, 17 Jun 2015 12:24:53 -0700
Message-ID: <xmqqlhfi6su2.fsf@gitster.dls.corp.google.com>
References: <558127CB.70603@web.de>
	<CACsJy8CuRcV2Rxaz8Ut4ayW-Hyd8Aao5W4JMc20jcfggOG3d4g@mail.gmail.com>
	<vpq8ubiwqo9.fsf@anie.imag.fr> <mlrmnt$te5$1@ger.gmane.org>
	<vpqoaketusa.fsf@anie.imag.fr> <mlrn9r$9ho$1@ger.gmane.org>
	<vpqtwu6sf4r.fsf@anie.imag.fr>
	<xmqqoake4akt.fsf@gitster.dls.corp.google.com>
	<xmqqd20u48at.fsf@gitster.dls.corp.google.com>
	<5581A3A3.1070908@web.de> <vpqh9q6gsdt.fsf@anie.imag.fr>
	<mlsc62$8u5$1@ger.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org
To: "Andres G. Aragoneses" <knocte@gmail.com>
X-From: git-owner@vger.kernel.org Wed Jun 17 21:25:15 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Z5IxK-0004Ac-P6
	for gcvg-git-2@plane.gmane.org; Wed, 17 Jun 2015 21:25:03 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757553AbbFQTY5 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 17 Jun 2015 15:24:57 -0400
Received: from mail-ig0-f172.google.com ([209.85.213.172]:38543 "EHLO
	mail-ig0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753175AbbFQTY4 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 17 Jun 2015 15:24:56 -0400
Received: by igblz2 with SMTP id lz2so44317079igb.1
        for <git@vger.kernel.org>; Wed, 17 Jun 2015 12:24:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version:content-type;
        bh=LUQBlaBLmHuF2l5iSVRTfxQFeXqDOeRsdZ/jBbJenzU=;
        b=GN65qZqHbIGcSmEU+JUNziMAyNTtwEixHy7RNXcUsMAvhKO8S/ZvJnHCakaWKrQiLm
         4NNge0OiJzKssxLY7ttXOTVV9F1ec2A23WQAkmVS9VNgkIizv/55R60/sqT7Pjz+AEfG
         n86+pUmQzYjXKKbYbogtxMTzWpOQUFGSQerESzPDTd9EGtZDg/ecjuAxDlOryNfcXpRj
         Z0vVqJdy6aIoqh6vvm/A3Dx+ZBHwV7+KeXiThxBXZzdtFloqJ7bSYGG93neqWXUCKbYD
         kTQ36NPr0MI/SUGgDkxpvEUBr8AyBEWYkEdWOitcrs9B7o1hPcP1QNZI/gE1ZDnj7eNF
         iPVg==
X-Received: by 10.50.64.243 with SMTP id r19mr13253286igs.5.1434569095361;
        Wed, 17 Jun 2015 12:24:55 -0700 (PDT)
Received: from localhost ([2620:0:10c2:1012:a4d4:8fab:953e:ec65])
        by mx.google.com with ESMTPSA id o9sm3185265ioe.35.2015.06.17.12.24.54
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Wed, 17 Jun 2015 12:24:54 -0700 (PDT)
In-Reply-To: <mlsc62$8u5$1@ger.gmane.org> (Andres G. Aragoneses's message of
	"Wed, 17 Jun 2015 19:53:06 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/271888>

"Andres G. Aragoneses" <knocte@gmail.com> writes:

> Comments?

No.
