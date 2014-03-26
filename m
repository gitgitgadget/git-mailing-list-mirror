From: Brad King <brad.king@kitware.com>
Subject: Re: [PATCH v2 16/27] t1400: Test one mistake at a time
Date: Wed, 26 Mar 2014 14:39:13 -0400
Message-ID: <53331ED1.7060804@kitware.com>
References: <1395683820-17304-1-git-send-email-mhagger@alum.mit.edu> <1395683820-17304-17-git-send-email-mhagger@alum.mit.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <gitster@pobox.com>,
	Johan Herland <johan@herland.net>, Jeff King <peff@peff.net>,
	Vicent Marti <tanoku@gmail.com>, git@vger.kernel.org
To: Michael Haggerty <mhagger@alum.mit.edu>
X-From: git-owner@vger.kernel.org Wed Mar 26 19:45:20 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WSspC-0006N0-Nm
	for gcvg-git-2@plane.gmane.org; Wed, 26 Mar 2014 19:45:19 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755550AbaCZSpK (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 26 Mar 2014 14:45:10 -0400
Received: from na6sys009bog001.obsmtp.com ([74.125.150.42]:53960 "HELO
	na6sys009bog001.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with SMTP id S1755425AbaCZSpJ (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 26 Mar 2014 14:45:09 -0400
Received: from mail-ie0-f177.google.com ([209.85.223.177]) (using TLSv1) by na6sys009bob001.postini.com ([74.125.148.12]) with SMTP
	ID DSNKUzMgNGRaBs4kCEbrmj/NcDH6HrFtche1@postini.com; Wed, 26 Mar 2014 11:45:09 PDT
Received: by mail-ie0-f177.google.com with SMTP id rl12so2017190iec.8
        for <git@vger.kernel.org>; Wed, 26 Mar 2014 11:45:08 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:message-id:date:from:user-agent:mime-version:to
         :cc:subject:references:in-reply-to:content-type
         :content-transfer-encoding;
        bh=+YSpimAMV6fqgF4HZzig53kIno63zKE4GoziUiCQ+QI=;
        b=moVCs85VHefQxHAtmb5CSiWx9d+SiO9ha2mfVQK/WRNdQ1eLbKm6bYmTb0CdpzUh9y
         2lLkaciPlWO2iJxDPHj65CdqBxtzTa3cI3/mZhPEz4ScwVFTPL8BGkqUS/HSHm87iZrF
         GcsIp3XQZ1J51cp5/A4lg04L4ImL7rjaOKexSnrrps9ofjFbP4CljhM/11wxpLJOWCIb
         S5Y5ugklJM+TGdCheIXzllxeKvPzt5AkyHqA7/bEKlxOiFpZTyKwaQL8Yvp6+sKqsGn7
         fIDhbYAhk4mS7bQBqz02Ly4W0CcQW5qHzN8Hu89+OGb9yTzHInZMgRxQfIRnIhL5Pkaf
         nj0Q==
X-Received: by 10.50.117.69 with SMTP id kc5mr25751681igb.25.1395859106195;
        Wed, 26 Mar 2014 11:38:26 -0700 (PDT)
X-Gm-Message-State: ALoCoQndqGezs1LmD8NXLCK7zWlugmvDTsi4MOLNMTyXH6uAEE7n/nTFkPZBALWy2eSEQ8h3VURw/v0c/mm2BASayczdp2O4fFytI9QL1QyfxVZ1INvkcZW+MKjNvtUn1ij+K2Pbg1MA1VjaCjCxO9GRUgABtXPftA==
X-Received: by 10.50.117.69 with SMTP id kc5mr25751678igb.25.1395859106126;
        Wed, 26 Mar 2014 11:38:26 -0700 (PDT)
Received: from [192.168.1.225] (tripoint.kitware.com. [66.194.253.20])
        by mx.google.com with ESMTPSA id z5sm61689igl.13.2014.03.26.11.38.24
        for <multiple recipients>
        (version=TLSv1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Wed, 26 Mar 2014 11:38:25 -0700 (PDT)
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:17.0) Gecko/20131103 Icedove/17.0.10
In-Reply-To: <1395683820-17304-17-git-send-email-mhagger@alum.mit.edu>
X-Enigmail-Version: 1.6
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/245205>

On 03/24/2014 01:56 PM, Michael Haggerty wrote:
> Signed-off-by: Michael Haggerty <mhagger@alum.mit.edu>
> 
> t1400: Add a test of "update" with too few arguments
> 
> Signed-off-by: Michael Haggerty <mhagger@alum.mit.edu>

This looks like a stray squash message.

-Brad
