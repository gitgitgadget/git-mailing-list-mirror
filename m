From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: Re: Pull is Mostly Evil
Date: Fri, 02 May 2014 18:23:35 -0500
Message-ID: <536428f7796e0_200c12912f03@nysa.notmuch>
References: <5363BB9F.40102@xiplink.com>
 <87k3a4xjzg.fsf@fencepost.gnu.org>
 <C439C0C76DA44AB5AAC91E7C0D2991BA@PhilipOakley>
 <5363ec734572a_70ef0f30cdc@nysa.notmuch>
 <2F8B2EEED0594446A6FCF771BBEDFB56@PhilipOakley>
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 7bit
To: Philip Oakley <philipoakley@iee.org>,
	Felipe Contreras <felipe.contreras@gmail.com>,
	git@vger.kernel.org, David Kastrup <dak@gnu.org>
X-From: git-owner@vger.kernel.org Sat May 03 01:34:22 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WgMyD-0001US-Lc
	for gcvg-git-2@plane.gmane.org; Sat, 03 May 2014 01:34:22 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753186AbaEBXeQ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 2 May 2014 19:34:16 -0400
Received: from mail-oa0-f41.google.com ([209.85.219.41]:63464 "EHLO
	mail-oa0-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751640AbaEBXeO (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 2 May 2014 19:34:14 -0400
Received: by mail-oa0-f41.google.com with SMTP id m1so3448815oag.0
        for <git@vger.kernel.org>; Fri, 02 May 2014 16:34:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=date:from:to:message-id:in-reply-to:references:subject:mime-version
         :content-type:content-transfer-encoding;
        bh=kyPCNa+y3mEdjVRwIR+5r3D1jQJv7ZA7CZ2MNnuV9z0=;
        b=l1lG1MK4+m21+wMfUO2hiFfQ5sdkwe9X00aMFXgoDWhi5gsOgFGJsZwpaQftwh23Vj
         /es0vNk23W6cgboNbC0xn3eOrHMTsZUzP8U9KGXUkNV/jlEQbxSUIrUh7qFzvpjjSAK7
         JWWZJUTFNaI37BXoGrcTKPLhwkz2PwOqf1nTdKWnHiYgTRxdDAIzkQJga97qqBGjgdnM
         vWGGFp8QOuO2csdOdPAO+RtVwJy8bCoEZT+mzAzJ5RfDZk+BHkq5xXcXY0wEjSyQCxn8
         d/PODxcfUZ1Yeb30NQSMeFTrR1PDLrw+QpOCQwTSHTMCHmeqVgoQTuo6BDsC7Czlql0u
         tHTg==
X-Received: by 10.182.28.134 with SMTP id b6mr18197402obh.27.1399073653829;
        Fri, 02 May 2014 16:34:13 -0700 (PDT)
Received: from localhost (189-211-224-40.static.axtel.net. [189.211.224.40])
        by mx.google.com with ESMTPSA id rt4sm1034378obb.12.2014.05.02.16.34.11
        for <multiple recipients>
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 02 May 2014 16:34:12 -0700 (PDT)
In-Reply-To: <2F8B2EEED0594446A6FCF771BBEDFB56@PhilipOakley>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/248008>

Philip Oakley wrote:
> From: "Felipe Contreras" <felipe.contreras@gmail.com>
> > So? No defaults can please absolutely everyone, the best anybody can
> > do is try to please the majority of people, and merging
> > fast-forwards only does that.
> 
> That assumes that doing something is better than doing nothing,

When doing something is better for the vast majority of people, that's
what should be done by default, unless the results are catastrophic for
the minority.

Since doing something is not catastrophic to the minority, it follows
that the default should be to do something.

It's a simple as that.

-- 
Felipe Contreras
