From: "Marco Costalba" <mcostalba@gmail.com>
Subject: Re: Why SHA are 40 bytes? (aka looking for flames)
Date: Sat, 21 Apr 2007 19:09:54 +0200
Message-ID: <e5bfff550704211009v119595d1x440be5ad0f95ee1c@mail.gmail.com>
References: <e5bfff550704210635r4008c3c6tf5f55f970bf85e44@mail.gmail.com>
	 <200704211608.06171.andyparkins@gmail.com>
	 <20070421165331.GA5080@diana.vm.bytemark.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: "Andy Parkins" <andyparkins@gmail.com>, git@vger.kernel.org
To: "=?ISO-8859-1?Q?Karl_Hasselstr=F6m?=" <kha@treskal.com>
X-From: git-owner@vger.kernel.org Sat Apr 21 19:10:00 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HfJ5z-0001Xh-8z
	for gcvg-git@gmane.org; Sat, 21 Apr 2007 19:09:59 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753528AbXDURJ4 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git@m.gmane.org>); Sat, 21 Apr 2007 13:09:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753566AbXDURJ4
	(ORCPT <rfc822;git-outgoing>); Sat, 21 Apr 2007 13:09:56 -0400
Received: from an-out-0708.google.com ([209.85.132.242]:25613 "EHLO
	an-out-0708.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753564AbXDURJz convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 21 Apr 2007 13:09:55 -0400
Received: by an-out-0708.google.com with SMTP id b33so1309813ana
        for <git@vger.kernel.org>; Sat, 21 Apr 2007 10:09:54 -0700 (PDT)
DKIM-Signature: a=rsa-sha1; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=umhgNMb6GnoRsqA4COUARcOnyD7KC100RLtmrXEsO7SbIWzw/BaMdrBG1AjOV8tJAtqvRMIG3y0Z2fPvhVUbkmWdJQjw5JBT7LOba4plfoCSByUe4Yii1TwTvEyT94bwy8/Q4V6HD3BA8RXzKv0UwOcbYiYhnuF6b6N6UR1uSCw=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=iM3iVcZVcdmB4dhKQ7rCU/FAbtYm+E8GzimclrXg1NCsBSiXwl0hyU0tCkQYbgIvJD8Flu2nPYnqdjG24eCMzFfsx3OgfqZr9X9lFf55QrmafjfsgmAZa0kzMGOlFKrJ2WAczJrsvx7sGI6teNCEtASXluRYL00uLiEIEdv6NpU=
Received: by 10.114.179.1 with SMTP id b1mr1775753waf.1177175394511;
        Sat, 21 Apr 2007 10:09:54 -0700 (PDT)
Received: by 10.114.61.6 with HTTP; Sat, 21 Apr 2007 10:09:54 -0700 (PDT)
In-Reply-To: <20070421165331.GA5080@diana.vm.bytemark.co.uk>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/45182>

On 4/21/07, Karl Hasselstr=F6m <kha@treskal.com> wrote:

> bits (note: this is 20 bytes, not 40)

Yes ;-) Of course. Sorry!!
