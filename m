From: Sverre Rabbelier <srabbelier@gmail.com>
Subject: Re: [PATCH] doc: technical details about the index file format
Date: Wed, 1 Sep 2010 10:20:49 -0500
Message-ID: <AANLkTi=uz250bEYdQssCSQar0OUJgDz3+CtYv-aVpdkh@mail.gmail.com>
References: <1283334825-18309-1-git-send-email-pclouds@gmail.com> <20100901103647.GA17260@kytes>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: =?UTF-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= <pclouds@gmail.com>,
	git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
	robin.rosenberg@dewire.com
To: Ramkumar Ramachandra <artagnon@gmail.com>
X-From: git-owner@vger.kernel.org Wed Sep 01 17:21:20 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Oqp7m-0004ga-T9
	for gcvg-git-2@lo.gmane.org; Wed, 01 Sep 2010 17:21:19 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755673Ab0IAPVL (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 1 Sep 2010 11:21:11 -0400
Received: from mail-gw0-f46.google.com ([74.125.83.46]:54663 "EHLO
	mail-gw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755576Ab0IAPVK (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 1 Sep 2010 11:21:10 -0400
Received: by gwj17 with SMTP id 17so3040561gwj.19
        for <git@vger.kernel.org>; Wed, 01 Sep 2010 08:21:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:mime-version:received:in-reply-to
         :references:from:date:message-id:subject:to:cc:content-type;
        bh=A9OcrA0DBPDFJzdPr4/Ia3HhzmTi8lY57tEfupRXN9o=;
        b=sQTDgF2O23xsdB6GAVnm0Vo3vf0fjF59JB/ytTAu8qSNuYK8v/jqNyN408tXm2j/Li
         1uiG4mlGaLsveZGovBerltrK6XpXqSGRRG35Rd/fE/Pf1xnGCgSfMRTHRXi+7mXc6/EU
         zZNLlUzD1+HXXeiTSYGhFOT2if0uYlRRd4JIg=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        b=qUR/3FcL5eBn3+Or5oIpR9f07Mwlun04GMWXy0sQh1usNrBSPSTZ4x+sG2VCUb74z4
         RpisPJEhz0Dlk/8uLGuZ+n56gqce2KxaI+NCJJUP4kXnIE9EDr8f62vTFELfTOHZM/BL
         rzjGRBkJEgy4j5L7ejSou7XmDEpuqBXUBRnrA=
Received: by 10.151.41.8 with SMTP id t8mr4000798ybj.165.1283354469267; Wed,
 01 Sep 2010 08:21:09 -0700 (PDT)
Received: by 10.151.49.17 with HTTP; Wed, 1 Sep 2010 08:20:49 -0700 (PDT)
In-Reply-To: <20100901103647.GA17260@kytes>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/155052>

Heya,

2010/9/1 Ramkumar Ramachandra <artagnon@gmail.com>:
> It might be more profitable to mention the Message-ID instead.
> <1202711335-12026-1-git-send-email-robin.rosenberg@dewire.com>

If you really want to do that, use this link:

http://mid.gmane.org/1202711335-12026-1-git-send-email-robin.rosenberg@dewire.com

-- 
Cheers,

Sverre Rabbelier
