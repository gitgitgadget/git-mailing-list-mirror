From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [PATCH] date.c: phrase a comment gender neutral
Date: Tue, 18 Nov 2014 11:42:42 -0800
Message-ID: <20141118194242.GJ6527@google.com>
References: <1416338668-30683-1-git-send-email-sbeller@google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: gitster@pobox.com, git@vger.kernel.org
To: Stefan Beller <sbeller@google.com>
X-From: git-owner@vger.kernel.org Tue Nov 18 20:44:29 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XqohQ-0000D1-4v
	for gcvg-git-2@plane.gmane.org; Tue, 18 Nov 2014 20:44:28 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755725AbaKRTnV (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 18 Nov 2014 14:43:21 -0500
Received: from mail-ie0-f171.google.com ([209.85.223.171]:47346 "EHLO
	mail-ie0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755183AbaKRTmm (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 18 Nov 2014 14:42:42 -0500
Received: by mail-ie0-f171.google.com with SMTP id rl12so4291404iec.30
        for <git@vger.kernel.org>; Tue, 18 Nov 2014 11:42:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        bh=JsY4K9Wmn7F5/cX+REnFOabA0oJ0aQ36tn+W+jWZPXQ=;
        b=JxdpWT1xHZr81MFs+acjsqfubJRUI6YoyNV6J/io6BTlJ2WKd8tkcKlZhxVKruZw9r
         +mt1kwk1piSLitLON/MAMWPYc/6Q/Vho6XEkowZ/d4yrzrSxNN3UkCtKvybh0fjvhKSq
         JwFM0uCrXUFNpLNk3MHpuGMSGTNkKeZYcDOOZa/JFUIMoF4vetZqm/JANKrxjpmjOsb2
         EqlqXLInwf5sh/OT9EtybHdWLxikcxQPLYC1OFjCMAzkiRRk4DLhjOIjfBu7smtBNDeW
         Q1TX4t2ZRSdc6fXU8w3/VKBHoitoD5fytL/vuBK2cySUeinm79qUSxZ1jnGyN2TLS82d
         Blxw==
X-Received: by 10.50.50.228 with SMTP id f4mr35794102igo.49.1416339761675;
        Tue, 18 Nov 2014 11:42:41 -0800 (PST)
Received: from google.com ([2620:0:1000:5b00:1d6d:1067:602d:d9c7])
        by mx.google.com with ESMTPSA id mf8sm8171305igb.22.2014.11.18.11.42.39
        for <multiple recipients>
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Tue, 18 Nov 2014 11:42:40 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <1416338668-30683-1-git-send-email-sbeller@google.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Stefan Beller wrote:

> When looking for suitable functions to print dates,
> I found this gem. Let's make it gender neutral as
> nowadays people get upset by this gender debate.

Eh, I'm not upset.

Hope that helps,
Jonathan
