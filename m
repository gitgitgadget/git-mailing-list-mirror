From: "David Symonds" <dsymonds@gmail.com>
Subject: Re: [PATCH 1/2] War on whitespace: first, a bit of retreat.
Date: Fri, 2 Nov 2007 23:53:24 +1100
Message-ID: <ee77f5c20711020553x1a329fa5g90f38d5b8c1a062e@mail.gmail.com>
References: <7vwst15ceq.fsf@gitster.siamese.dyndns.org>
	 <ee77f5c20711020314h43290dbs8141cb3905c867@mail.gmail.com>
	 <472AFFE4.9060004@op5.se>
	 <ee77f5c20711020450hdfe064fsace9349fe6494ec9@mail.gmail.com>
	 <fgf4qu$e8c$1@ger.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: "Jakub Narebski" <jnareb@gmail.com>
X-From: git-owner@vger.kernel.org Fri Nov 02 13:53:42 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Inw1s-00080G-VY
	for gcvg-git-2@gmane.org; Fri, 02 Nov 2007 13:53:41 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754534AbXKBMx0 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 2 Nov 2007 08:53:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754225AbXKBMx0
	(ORCPT <rfc822;git-outgoing>); Fri, 2 Nov 2007 08:53:26 -0400
Received: from rv-out-0910.google.com ([209.85.198.190]:52582 "EHLO
	rv-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754152AbXKBMxZ (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 2 Nov 2007 08:53:25 -0400
Received: by rv-out-0910.google.com with SMTP id k20so794495rvb
        for <git@vger.kernel.org>; Fri, 02 Nov 2007 05:53:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        bh=vkUqYQhoTpTALVfQGbE+skWYldZlPBOl5XlPk4itH/8=;
        b=RA9a0caTgcmUx0d5RZ3hsHB9D8aQVvWfdAQlfwBZ66hWTofXBrATY0U2bUCsJVgQSjRo0udbn2T02vxxEZ1kdbgxUxZv2poaNwtp2FZbtdJtg8rcdWdbtsZ0j8nnMM7DWMyRtHApYE9u16MBvSZTZrr1He8IzUzilhkCLOf2Pco=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=QOLJEawAaTeSmCHwAO3JyZ9oNP3853ILTzCJJEXMU+1cbymA5IT9mFL5r6t4fz0E9wcdGFGesQ21jJO/uVQGUjSOGM1skNKu4yFhiNCjlIvp8af6L5y5qI5swnjveyAGbYZVews7rqM8Xr7bYbMSLiJm9j7x4NC9btzsx1w3Hi4=
Received: by 10.140.157.4 with SMTP id f4mr843191rve.1194008004345;
        Fri, 02 Nov 2007 05:53:24 -0700 (PDT)
Received: by 10.141.115.4 with HTTP; Fri, 2 Nov 2007 05:53:24 -0700 (PDT)
In-Reply-To: <fgf4qu$e8c$1@ger.gmane.org>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/63113>

On 11/2/07, Jakub Narebski <jnareb@gmail.com> wrote:
> Nice idea, but the syntax is
>
> [core "whitespace"]
>         trailing = error
>         space-before-tab = error
>         indent-with-space = warn

Whoops, of course. My brain is a bit muddled tonight.



Dave.
