From: "Imran M Yousuf" <imyousuf@gmail.com>
Subject: Re: [PATCH] Use '-f' option to point to the .gitmodules file
Date: Tue, 20 May 2008 09:12:02 +0600
Message-ID: <7bfdc29a0805192012w5bf3a158y81f9623d57b71b10@mail.gmail.com>
References: <1210837378-25668-1-git-send-email-imyousuf@gmail.com>
	 <alpine.DEB.1.00.0805150956050.30431@racer>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org,
	"Imran M Yousuf" <imyousuf@smartitengineering.com>
To: gitster@pobox.com
X-From: git-owner@vger.kernel.org Tue May 20 05:13:00 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JyIHY-0007yO-Le
	for gcvg-git-2@gmane.org; Tue, 20 May 2008 05:12:57 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755009AbYETDMG (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 19 May 2008 23:12:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754968AbYETDMF
	(ORCPT <rfc822;git-outgoing>); Mon, 19 May 2008 23:12:05 -0400
Received: from yw-out-2324.google.com ([74.125.46.30]:48794 "EHLO
	yw-out-2324.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752151AbYETDMC (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 19 May 2008 23:12:02 -0400
Received: by yw-out-2324.google.com with SMTP id 9so1279801ywe.1
        for <git@vger.kernel.org>; Mon, 19 May 2008 20:12:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        bh=yENA5EJWxSw1JXAoYB8acHYtLX6HvOFJgz4iYRllJWI=;
        b=b/h3HwzK52U+W+pJiHC+oOw+T7SV0aJIakhRhD+iZzkNBwVRY8OEfXxqqE6CY8zHfDyVgidFBxOj7Tjwg4Wu1+4iIZ7ILhAgJcuhxSbVI+WVqLKgxq63iQcJeBJS956PI7Fha3/keorcxbYNH+nLPgh7ekLLXe563OIfXrfKYMo=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=nqi9qfODsiqmuN7W/K1RbNlAOzqJRWUa0M8PDYUDTIepWNbQhdzvC8B009yYqRYgtYfxaQWbSfYUWgeDbCHMiYrDZCcUVNA/5vmhRtpk9zbX/P1N/oG5QhU8rrJutlIwkQUqVZVvrR9+iWlMXPo2fXjZxiKIxD26/WAREdRTCZI=
Received: by 10.150.79.22 with SMTP id c22mr7088444ybb.160.1211253122077;
        Mon, 19 May 2008 20:12:02 -0700 (PDT)
Received: by 10.150.54.11 with HTTP; Mon, 19 May 2008 20:12:02 -0700 (PDT)
In-Reply-To: <alpine.DEB.1.00.0805150956050.30431@racer>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/82461>

Thanks for accepting the patch :).

Best regards,

Imran
On Thu, May 15, 2008 at 2:56 PM, Johannes Schindelin
<Johannes.Schindelin@gmx.de> wrote:
> Hi,
>
> On Thu, 15 May 2008, imyousuf@gmail.com wrote:
>
>> From: Imran M Yousuf <imyousuf@smartitengineering.com>
>>
>> 'git config' has a '-f' option that takes the file to parse.
>> Using it rather than the environment variable seems more logical
>> and simplified.
>
> Definitely looks more readable.
>
> Ciao,
> Dscho
>



-- 
Imran M Yousuf
