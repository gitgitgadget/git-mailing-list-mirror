From: "Catalin Marinas" <catalin.marinas@gmail.com>
Subject: Re: [PATCH] Check git pull remote before defaulting to 'origin'
Date: Tue, 9 Jan 2007 10:30:49 +0000
Message-ID: <b0943d9e0701090230j3611784bw5c2db84576327bd1@mail.gmail.com>
References: <1165657360.2816.61.camel@portland.localdomain>
	 <b0943d9e0612100841h7d064c7cs37f882f91e3eddf8@mail.gmail.com>
	 <1168327205.7890.2.camel@dv>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Jan 09 11:31:03 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1H4EFt-0001Cy-R3
	for gcvg-git@gmane.org; Tue, 09 Jan 2007 11:30:58 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751282AbXAIKaz (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 9 Jan 2007 05:30:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751289AbXAIKaz
	(ORCPT <rfc822;git-outgoing>); Tue, 9 Jan 2007 05:30:55 -0500
Received: from nz-out-0506.google.com ([64.233.162.224]:18560 "EHLO
	nz-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751282AbXAIKay (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 9 Jan 2007 05:30:54 -0500
Received: by nz-out-0506.google.com with SMTP id s1so3957690nze
        for <git@vger.kernel.org>; Tue, 09 Jan 2007 02:30:54 -0800 (PST)
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=oW4QFqe8mQgD0akNMkHZP+bUyF4pPm8Bp2m8vBwW2RXuEXj6yAkvtbvtW1BXy8lOrEUNnN+Wci4RSXEnDRwqH11gsqNb5CKMsuEBlgNyg3BLBaZaM8C6Doh0Pih6UR3sfHrWdfAO5gdphofuVN0OiU2txIRwpECLx155PwFm6Ho=
Received: by 10.65.154.4 with SMTP id g4mr483372qbo.1168338654145;
        Tue, 09 Jan 2007 02:30:54 -0800 (PST)
Received: by 10.65.133.13 with HTTP; Tue, 9 Jan 2007 02:30:49 -0800 (PST)
To: "Pavel Roskin" <proski@gnu.org>
In-Reply-To: <1168327205.7890.2.camel@dv>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/36342>

On 09/01/07, Pavel Roskin <proski@gnu.org> wrote:
> Check git pull remote before defaulting to 'origin'

Thanks. Applied.

-- 
Catalin
