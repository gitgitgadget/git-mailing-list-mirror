From: "Martin Langhoff" <martin.langhoff@gmail.com>
Subject: Re: Using thunderbird to post/apply patches?
Date: Fri, 8 Feb 2008 17:27:20 +1300
Message-ID: <46a038f90802072027h759114b1l3a2b861505eded2c@mail.gmail.com>
References: <46a038f90802071521n674b61c2t5e4d4c740375b951@mail.gmail.com>
	 <alpine.LSU.1.00.0802072333120.11591@racer.site>
	 <46a038f90802071542j765a8501kc57b065f22c734b2@mail.gmail.com>
	 <alpine.LSU.1.00.0802080011420.11591@racer.site>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: "Git Mailing List" <git@vger.kernel.org>
To: "Johannes Schindelin" <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Fri Feb 08 05:28:12 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JNKqQ-0002in-LG
	for gcvg-git-2@gmane.org; Fri, 08 Feb 2008 05:28:11 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1760261AbYBHE1W (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 7 Feb 2008 23:27:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1760120AbYBHE1W
	(ORCPT <rfc822;git-outgoing>); Thu, 7 Feb 2008 23:27:22 -0500
Received: from ug-out-1314.google.com ([66.249.92.172]:60488 "EHLO
	ug-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1760094AbYBHE1V (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 7 Feb 2008 23:27:21 -0500
Received: by ug-out-1314.google.com with SMTP id z38so823087ugc.16
        for <git@vger.kernel.org>; Thu, 07 Feb 2008 20:27:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        bh=6kzgW0Gw46ZWrkECsbrv5AMi8VYlw19HlaaltPzaqwM=;
        b=Kv2fqeONIAf33xkLGheRc0IwDNuW4fIYSYmUe0RCIIJOPe/iNutxAwLfXObzP9WlxSzs5Ry+UZsZdc/E8AQMBu6oK7n9RtvPbVeydfu7P9e3N2zTSDF1a/oh/VzdxFaBjK/WT4a8JZBdZ458RmI/qaVTyNjwMXmJKboh1I5NCyM=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=h9mg//8+9x9mBpmZ8efwPdmlrtSjuUDTv1a/Q7BdF6nOVdE4/f5cZW6gE5TALdOCGSejEVOWB8bhxXHhPIXSbyAleQQ2bDbLPjt+mV5xDNsZe5MyOhKfzUkF8WSCoIIup02wYz42rfDiHeP574ODRJCAbWtvXAmR+LOanwW+Tn8=
Received: by 10.67.20.11 with SMTP id x11mr4140901ugi.29.1202444840135;
        Thu, 07 Feb 2008 20:27:20 -0800 (PST)
Received: by 10.66.250.13 with HTTP; Thu, 7 Feb 2008 20:27:20 -0800 (PST)
In-Reply-To: <alpine.LSU.1.00.0802080011420.11591@racer.site>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/73033>

On Feb 8, 2008 1:12 PM, Johannes Schindelin <Johannes.Schindelin@gmx.de> wrote:
> Do you have an example of a non-working mbox for git-am?

good news - tested the mbox files I have (which used to get git-am to
barf back in the v0.99 days), and they work well. So things have
gotten much better on that front... probably git mailsplit got
smarter. I doubt thunderbird has changed one bit :-)

cheers!


m
