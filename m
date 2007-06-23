From: "Lars Hjemli" <hjemli@gmail.com>
Subject: Re: [PATCH][RESEND] git-submodule: provide easy way of adding new submodules
Date: Sat, 23 Jun 2007 21:26:56 +0200
Message-ID: <8c5c35580706231226lc887320ubce71d90dda8e9d3@mail.gmail.com>
References: <20070621095300.GA27071MdfPADPa@greensroom.kotnet.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, "Junio C Hamano" <gitster@pobox.com>
To: skimo@liacs.nl
X-From: git-owner@vger.kernel.org Sat Jun 23 21:27:06 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1I2BG7-0002CG-JM
	for gcvg-git@gmane.org; Sat, 23 Jun 2007 21:26:59 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752883AbXFWT06 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 23 Jun 2007 15:26:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752849AbXFWT06
	(ORCPT <rfc822;git-outgoing>); Sat, 23 Jun 2007 15:26:58 -0400
Received: from wa-out-1112.google.com ([209.85.146.181]:23460 "EHLO
	wa-out-1112.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752724AbXFWT05 (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 23 Jun 2007 15:26:57 -0400
Received: by wa-out-1112.google.com with SMTP id v27so1196894wah
        for <git@vger.kernel.org>; Sat, 23 Jun 2007 12:26:56 -0700 (PDT)
DKIM-Signature: a=rsa-sha1; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=Cy3il/0jOGaM2oFQxxOHxxCEx9i/CXsRLqA4kUQp6VOFWq+ytP981f6F4DjXf/4tVcDXnzbJGCZkt+nxvksk+zqEc7BTGdA2Vi4xAhp6Ee9T6crX3Jy1BTe6XtMA5srrrEXWkJmQZP+b8HeCBDL8VwfkzP5HeGQ8nkyNPzQAIKg=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=kAsWUAVEqaWUW/97WCC0IEjfcuuFxyz7cQXOYbcnSATgaYf0yAUPX2r0Tzj7j85EuJmoVOSsPGcTNSz8uEs8swGO9zyGC3npk9xFZ7sR54htkPNI8V5Xq4GBuUpOgbX04cAywulpxSO1e84Q3Zdv4jmwb/p10JiW/JUMiQTJRL4=
Received: by 10.115.77.1 with SMTP id e1mr4052726wal.1182626816905;
        Sat, 23 Jun 2007 12:26:56 -0700 (PDT)
Received: by 10.114.235.4 with HTTP; Sat, 23 Jun 2007 12:26:56 -0700 (PDT)
In-Reply-To: <20070621095300.GA27071MdfPADPa@greensroom.kotnet.org>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/50745>

On 6/21/07, Sven Verdoolaege <skimo@kotnet.org> wrote:
> I didn't get any reaction (negative or positive) to this patch.

Sorry for the late reply, I've been buried in day-job stuff lately
(and still is).

The patch looks sane to me. I'll try to play around with it tomorrow
and give some more feedback.

--
larsh
