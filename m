From: "Marco Costalba" <mcostalba@gmail.com>
Subject: Re: [ANNOUNCE] qgit-2.0rc1
Date: Sun, 10 Jun 2007 16:21:18 +0200
Message-ID: <e5bfff550706100721i1226ebaaweaa1d1d6c96990af@mail.gmail.com>
References: <e5bfff550706100447g5d34adf2j92389cd193658738@mail.gmail.com>
	 <20070610140356.GF4084@efreet.light.src>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Cc: "Git Mailing List" <git@vger.kernel.org>,
	"Pavel Roskin" <proski@gnu.org>,
	"Andy Parkins" <andyparkins@gmail.com>
To: "Jan Hudec" <bulb@ucw.cz>
X-From: git-owner@vger.kernel.org Sun Jun 10 16:21:26 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HxOID-000090-7W
	for gcvg-git@gmane.org; Sun, 10 Jun 2007 16:21:21 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754789AbXFJOVU (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 10 Jun 2007 10:21:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754944AbXFJOVT
	(ORCPT <rfc822;git-outgoing>); Sun, 10 Jun 2007 10:21:19 -0400
Received: from wa-out-1112.google.com ([209.85.146.179]:60545 "EHLO
	wa-out-1112.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754320AbXFJOVT (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 10 Jun 2007 10:21:19 -0400
Received: by wa-out-1112.google.com with SMTP id v27so1765655wah
        for <git@vger.kernel.org>; Sun, 10 Jun 2007 07:21:18 -0700 (PDT)
DKIM-Signature: a=rsa-sha1; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=fpfQ5Wt4vjsbmwCqHGyLKUfTKYe1Kn0T89mPZ3UIVaFSMENllOyx7o+sXfCQYiSJEgmqjR6zqTBohpQcGJ4PEUGwJwPeMus2R1NoUXeCpWU9bEHrVaeeDSQq49TuAiksMM1FJoLm7bGxOm66OK1LYH4j+Zln3KJTVY7vnlfd6QE=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=pym8KiOeyz199WN5Xkb/Kvi7p032Cd80aVzfd3SNiYVG4NYEGSQ/Ulj1uK9S1CYYoBRfMKPqReAYn/XTLrS+RazUoUPEsrD3+J1KTdMvEvS3qeKUPY+zZpSaM9jAwNW+OuRQGVXa0jyft4ABHMmpm5UMj8lhWiKDmU+R9H+Yz7c=
Received: by 10.114.121.1 with SMTP id t1mr4594611wac.1181485278775;
        Sun, 10 Jun 2007 07:21:18 -0700 (PDT)
Received: by 10.114.56.6 with HTTP; Sun, 10 Jun 2007 07:21:18 -0700 (PDT)
In-Reply-To: <20070610140356.GF4084@efreet.light.src>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/49739>

On 6/10/07, Jan Hudec <bulb@ucw.cz> wrote:
> On Sun, Jun 10, 2007 at 13:47:17 +0200, Marco Costalba wrote:
> > This is qgit-2.0rc1
>
> Can you please fix the license?
>

Yes of course. Thanks for noticing.

Already pushed to public git repo, will be included in following rc2
as soon as we get to fix the strange build problem on Ismail box.

Thanks
Marco
