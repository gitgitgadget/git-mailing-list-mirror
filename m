From: Mark Ryden <markryde@gmail.com>
Subject: Re: git diff and getting a list of files which have diffs
Date: Thu, 5 Feb 2009 09:40:08 +0200
Message-ID: <dac45060902042340ja0ec57fq84ef33dc4a089a17@mail.gmail.com>
References: <dac45060902041435m3f884475j7f359ee694048ee5@mail.gmail.com>
	 <498A1931.4000606@freescale.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Jon Loeliger <jdl@freescale.com>
X-From: git-owner@vger.kernel.org Thu Feb 05 08:41:38 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LUyrh-0003fq-ND
	for gcvg-git-2@gmane.org; Thu, 05 Feb 2009 08:41:38 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753287AbZBEHkM (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 5 Feb 2009 02:40:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751870AbZBEHkL
	(ORCPT <rfc822;git-outgoing>); Thu, 5 Feb 2009 02:40:11 -0500
Received: from mail-ew0-f21.google.com ([209.85.219.21]:50202 "EHLO
	mail-ew0-f21.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753262AbZBEHkK (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 5 Feb 2009 02:40:10 -0500
Received: by ewy14 with SMTP id 14so103865ewy.13
        for <git@vger.kernel.org>; Wed, 04 Feb 2009 23:40:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=TaYPPq9pVdWdLbI7c6cYL3II9GRmOW+oGfLJv+EqR8Q=;
        b=X4y77dnojL58kRfc+G4Mk25nWoVnuh/NdIBMjj8ERogUKgmiymMJWlTiQx7RRrXnBi
         EFkdIGF6hHw9U3kHn5tsGRrxGg8PhxmGCmP+7R1eyxi7r1Ssw6f9dBL8DqQMQZiPq9b6
         +NeCqBdTdiDBNlAqmi74p5BDl+6ip0qYAX7u4=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=KFbz5007uZ8OAjRfjNTdHcgSnrApPbapQOEIExQIiOSjo/VAAci0rPDWHasZPpE7TY
         OQrhxyY6tsLgMU9MMAYCnA42DUsW6liQ6nTCmhiJtjqv3gBzoEw1gGpB+ChSOlUeT4FC
         GxuWmcCKjcgYEHOs8DGf8w3oAp5YfztlEvp/E=
Received: by 10.210.11.17 with SMTP id 17mr168293ebk.32.1233819608843; Wed, 04 
	Feb 2009 23:40:08 -0800 (PST)
In-Reply-To: <498A1931.4000606@freescale.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/108513>

Hello,
Yes ! Thanks!
Mark

On Thu, Feb 5, 2009 at 12:39 AM, Jon Loeliger <jdl@freescale.com> wrote:
> Mark Ryden wrote:
>>
>> Hello,
>> git diff shows the differneces between a tree and the working tree.
>> Is there a way to get only the list of file names that have such
>> differences
>> without getting the differences themselves ?
>> Rgs,
>> Mark
>
> --name-only ?
>
> jdl
>
>
>
>
