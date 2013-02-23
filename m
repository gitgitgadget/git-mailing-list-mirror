From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [PATCH v2 3/2] update-index: list supported idx versions and
 their features
Date: Sat, 23 Feb 2013 12:55:14 -0800
Message-ID: <20130223205514.GD3222@elie.Belkin>
References: <1361534964-4232-2-git-send-email-pclouds@gmail.com>
 <1361586571-12917-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
To: =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Sat Feb 23 21:55:47 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1U9M8G-00048z-13
	for gcvg-git-2@plane.gmane.org; Sat, 23 Feb 2013 21:55:44 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758445Ab3BWUzU convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sat, 23 Feb 2013 15:55:20 -0500
Received: from mail-da0-f51.google.com ([209.85.210.51]:46170 "EHLO
	mail-da0-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757808Ab3BWUzT convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 23 Feb 2013 15:55:19 -0500
Received: by mail-da0-f51.google.com with SMTP id n15so879936dad.38
        for <git@vger.kernel.org>; Sat, 23 Feb 2013 12:55:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-received:date:from:to:cc:subject:message-id:references
         :mime-version:content-type:content-disposition
         :content-transfer-encoding:in-reply-to:user-agent;
        bh=xt7WzJqAUoNzt5I2k/76SpPWhOlK27OFJ3Eny13R52I=;
        b=0zZbtK94oxKq6BrFiUgaLDvSvhxMmr1c0PkYs/CARhL/gmWDZlmOcEtTFlPRjAg01W
         sWd8zpUDBpWfKth4+nu8L8CUnltS1OePDLs1hDRnBJuh961tYb0CuvDwl3n89ggEHeSf
         1gQtr729LMYt5+96t7kx0CgUT9TaqClTucT25FjB834dpuX6RPYqnRF44aBZMvqby+4k
         ufuRuUNGVycjSnoQ467y9I25WDSir3ANUiFlZwG4AYQ0BIwDWebOWXrB8/BaoC00uEk0
         4fTzbsSJGsxm932VOxemEhiv6bLLZORF7MzmTAVgfVYhYxTLOTuRq+OiRaerySJKhbXE
         46Uw==
X-Received: by 10.68.129.163 with SMTP id nx3mr10212596pbb.13.1361652918950;
        Sat, 23 Feb 2013 12:55:18 -0800 (PST)
Received: from elie.Belkin (c-107-3-135-164.hsd1.ca.comcast.net. [107.3.135.164])
        by mx.google.com with ESMTPS id qp13sm7012972pbb.3.2013.02.23.12.55.16
        (version=TLSv1.2 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Sat, 23 Feb 2013 12:55:17 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <1361586571-12917-1-git-send-email-pclouds@gmail.com>
User-Agent: Mutt/1.5.21+51 (9e756d1adb76) (2011-07-01)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/216914>

Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy wrote:

>  Oops, bogus indentation in the first 3/2

Oops, I missed this.  Ok, ignore the comment on indentation on v1. :)

With or without the other changes I suggested,
Reviewed-by: Jonathan Nieder <jrnieder@gmail.com>
