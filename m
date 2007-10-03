From: Andy Parkins <andyparkins@gmail.com>
Subject: Re: [PATCH] Change "refs/" references to symbolic constants
Date: Wed, 3 Oct 2007 12:13:09 +0100
Message-ID: <200710031213.15749.andyparkins@gmail.com>
References: <20071002155800.GA6828@coredump.intra.peff.net> <20071002191104.GA7901@coredump.intra.peff.net> <200710030850.19614.andyparkins@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Cc: Jeff King <peff@peff.net>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Oct 03 13:13:35 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Id2AX-0006Qg-W0
	for gcvg-git-2@gmane.org; Wed, 03 Oct 2007 13:13:34 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754039AbXJCLNZ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 3 Oct 2007 07:13:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753859AbXJCLNY
	(ORCPT <rfc822;git-outgoing>); Wed, 3 Oct 2007 07:13:24 -0400
Received: from ug-out-1314.google.com ([66.249.92.173]:54571 "EHLO
	ug-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753198AbXJCLNY (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 3 Oct 2007 07:13:24 -0400
Received: by ug-out-1314.google.com with SMTP id z38so95153ugc
        for <git@vger.kernel.org>; Wed, 03 Oct 2007 04:13:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:from:to:subject:date:user-agent:cc:references:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:message-id;
        bh=P8OO+tiV7Z7lRCG2EhTKplf8tuY9KlHJicWAFrNCfJU=;
        b=mszKt9qRn4JhB+POm8CF7JD1p7T40fuQDI4JexVQe/jvzI9ETD5vBPT19FKAO/vvFWGuszxrFy4l8iI5ElmH1kFnkXnenjiw64SWIB9UrDNgubgsbUNACr2VSnfAKuIvOCFykM96nX7gvHhYQ8ALWSuaI2IMi2duZXCJ6QSpFf8=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:from:to:subject:date:user-agent:cc:references:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:message-id;
        b=M+nrhcbczaROsLCqlCvVXTItqcgzFuW89p0KMkSWTyETFuQkUJANN/KHGZuG28IeyUUxy7zy16FrDYPG7QrK6gLZpsowFr/GmrY7n9AIcjRm14Dp4ZPb0MyR38d7417mb3TrG/g2KxBwOfvq7/RFiEDlFV4wjyA4XOLph/DOUQQ=
Received: by 10.67.20.19 with SMTP id x19mr356837ugi.1191410002000;
        Wed, 03 Oct 2007 04:13:22 -0700 (PDT)
Received: from dvr.360vision.com ( [194.70.53.227])
        by mx.google.com with ESMTPS id c22sm211358ika.2007.10.03.04.13.20
        (version=TLSv1/SSLv3 cipher=OTHER);
        Wed, 03 Oct 2007 04:13:21 -0700 (PDT)
User-Agent: KMail/1.9.7
In-Reply-To: <200710030850.19614.andyparkins@gmail.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/59824>

On Wednesday 2007 October 03, Andy Parkins wrote:

> I put a comment above the other changes like this in the same file, but
> thought I was being overly verbose putting it in every single time.  I'm
> happy to copy the comment around in the file though.

I'm a liar; I remember writing them, but they're not in the patch.  Perhaps 
they are still in my working tree at home.  Anyway; you're point was correct, 
I'll find the explanatory comments or write new ones and add them to the 
patch.



Andy
-- 
Dr Andy Parkins, M Eng (hons), MIET
andyparkins@gmail.com
