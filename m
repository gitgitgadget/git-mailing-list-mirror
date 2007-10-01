From: "David Symonds" <dsymonds@gmail.com>
Subject: Re: git-browser and branch names
Date: Tue, 2 Oct 2007 01:34:45 +1000
Message-ID: <ee77f5c20710010834l2c7ae4cdqb09445bff2f3835d@mail.gmail.com>
References: <ee77f5c20710010424x1f83aa10kcde7033711b02093@mail.gmail.com>
	 <C4186BBD-11BA-4A58-9230-00076FF6F8F7@yahoo.ca>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Git <git@vger.kernel.org>
To: "=?ISO-8859-1?Q?Jean-Fran=E7ois_Veillette?=" 
	<jean_francois_veillette@yahoo.ca>
X-From: git-owner@vger.kernel.org Mon Oct 01 17:35:18 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IcNIP-0007lr-Li
	for gcvg-git-2@gmane.org; Mon, 01 Oct 2007 17:34:58 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751733AbXJAPer convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 1 Oct 2007 11:34:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751982AbXJAPeq
	(ORCPT <rfc822;git-outgoing>); Mon, 1 Oct 2007 11:34:46 -0400
Received: from wa-out-1112.google.com ([209.85.146.177]:24397 "EHLO
	wa-out-1112.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751723AbXJAPeq convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 1 Oct 2007 11:34:46 -0400
Received: by wa-out-1112.google.com with SMTP id v27so4603785wah
        for <git@vger.kernel.org>; Mon, 01 Oct 2007 08:34:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        bh=5j2VbcLIoY6BlgIOOWuZDsMJZeDiPrUWUMcuhRbf6MY=;
        b=Ua9uLmsGilH3u6UWljxJD8dhA4P/lrXJJkz95q89IQvzK9e+uTPCe67DA6v1LcenhkczS2jW55ySOO1o9ro6JQxdyVu1TltJG9qh9MGCVrHkITmkXsWQkdhVoSHIaPCPuNwWV6i12OxHCxD9JjujCE0XFRD97cL2JndqWc4LIkI=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=eiwLSgxvkRVMxqs29yQrp2rF5KqTTYB0tgGZvo+MB+qWgM5X80EDp4UIk4VtXbxN+1lpRqj4K05brWzHlMpMCTjWAPzg2VEF6Uzb5P930SbsxB3iryiRC8UqTbJOlPKjH9ipIaubgX+FewnZyH3O+hrlSb/QZGP+QO9Cf/Gumh4=
Received: by 10.114.194.1 with SMTP id r1mr829191waf.1191252885436;
        Mon, 01 Oct 2007 08:34:45 -0700 (PDT)
Received: by 10.141.153.4 with HTTP; Mon, 1 Oct 2007 08:34:45 -0700 (PDT)
In-Reply-To: <C4186BBD-11BA-4A58-9230-00076FF6F8F7@yahoo.ca>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/59621>

On 01/10/2007, Jean-Fran=E7ois Veillette <jean_francois_veillette@yahoo=
=2Eca> wrote:
> Le 07-10-01 =E0 07:24, David Symonds a =E9crit :
> >
> > Can anyone give me pointers or suggestions as to where to start
> > debugging this? Anyone else encountered this?
>
> To debug html/javascript use  Firefox and Firebug.
> http://www.getfirebug.com/

Great, thanks for the pointer. My first real foray into Javascript has
been successful -- a patch will soon follow.


Dave.
