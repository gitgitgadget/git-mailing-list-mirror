From: "Marco Costalba" <mcostalba@gmail.com>
Subject: Re: [Qgit RFC] commit --amend
Date: Mon, 11 Jun 2007 07:24:00 +0200
Message-ID: <e5bfff550706102224k5fd32cf9x5e449f9bed708585@mail.gmail.com>
References: <20070610150839.GG4084@efreet.light.src>
	 <e5bfff550706101510x6d685944ja70c9d9dbb3668f6@mail.gmail.com>
	 <20070611044258.GJ4084@efreet.light.src>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: "Jan Hudec" <bulb@ucw.cz>
X-From: git-owner@vger.kernel.org Mon Jun 11 07:24:07 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HxcNr-00047R-2p
	for gcvg-git@gmane.org; Mon, 11 Jun 2007 07:24:07 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750784AbXFKFYE (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 11 Jun 2007 01:24:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751091AbXFKFYE
	(ORCPT <rfc822;git-outgoing>); Mon, 11 Jun 2007 01:24:04 -0400
Received: from nz-out-0506.google.com ([64.233.162.224]:57500 "EHLO
	nz-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750784AbXFKFYB (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 11 Jun 2007 01:24:01 -0400
Received: by nz-out-0506.google.com with SMTP id n1so1142591nzf
        for <git@vger.kernel.org>; Sun, 10 Jun 2007 22:24:01 -0700 (PDT)
DKIM-Signature: a=rsa-sha1; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=bfAvjRXeAOLVsdrQ1x6Pe4JdH3OVTdKgeX2DGUaq7z/Fxzm+ZzrD+23pY+E9DPwVd/zrRxUKZbVw4QLj6quMuC5qcMbh9v5bv8eUeXW9JYsrqc4kljZRV9x2+QswQra+ZgtnX5nRO99VxLGgsMlVPPTgY65PFesmEUUPnNKiMUc=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=HQjO5ULWz16w8H5yr8cXnAsqEuwVUkfV0dOh7ru3U9aWrhTWuWmvlBIxFsDY7v78QEnoBUkxn+C6w/IghRefO4udF+j/3NO+4U0e6FIVJDIkWZuTD9cisXVr7+kRJQ2kZB9Ct5kWrEdOhcS6wCL+b7TWJl6P8IUEA4rrDq1k/DY=
Received: by 10.114.173.15 with SMTP id v15mr5171594wae.1181539440683;
        Sun, 10 Jun 2007 22:24:00 -0700 (PDT)
Received: by 10.114.56.6 with HTTP; Sun, 10 Jun 2007 22:24:00 -0700 (PDT)
In-Reply-To: <20070611044258.GJ4084@efreet.light.src>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/49818>

On 6/11/07, Jan Hudec <bulb@ucw.cz> wrote:
>
> So I am now inclined more to the separate action and trying to go that way.
> But the difference between the variants would not be that big.
>

Ok for me. Please, feel free to implement what's the best for you and
I will apply the patch.

Marco
