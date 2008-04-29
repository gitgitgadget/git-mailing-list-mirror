From: "Matt Graham" <mdg149@gmail.com>
Subject: Re: Yet another Git tutorial
Date: Mon, 28 Apr 2008 21:25:51 -0400
Message-ID: <1c5969370804281825m378b8714q809f13eb6192623@mail.gmail.com>
References: <2D3D2E55-74C7-4373-BC22-9CF4C26C197D@newartisans.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: "John Wiegley" <johnw@newartisans.com>
X-From: git-owner@vger.kernel.org Tue Apr 29 03:26:48 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JqecI-0001bH-Si
	for gcvg-git-2@gmane.org; Tue, 29 Apr 2008 03:26:47 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751529AbYD2BZ4 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 28 Apr 2008 21:25:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751272AbYD2BZ4
	(ORCPT <rfc822;git-outgoing>); Mon, 28 Apr 2008 21:25:56 -0400
Received: from wf-out-1314.google.com ([209.85.200.169]:41159 "EHLO
	wf-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751162AbYD2BZy (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 28 Apr 2008 21:25:54 -0400
Received: by wf-out-1314.google.com with SMTP id 28so4274487wff.4
        for <git@vger.kernel.org>; Mon, 28 Apr 2008 18:25:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        bh=orci/r+x3WWmqig67bvFYL2aHaf2on1ucgZwNkRULDE=;
        b=L3R0JjgrQnyiD4tZyrMzy5dokOktPIB3prNVPpBrd/zT6gxA6xy57DBzX843g/Sm6zPmcQ/DsZh1j4IQGuREkliNLepExlqwzHYg4K1elhaIf9jccL0KsRKheqEwWwxDXZlOB3Lrop9yRGolduvLWE8KHlYd0ZqZlb6eVBuwwQg=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=KQqG88VgRT1JTVohn7yxEmS3TM3J9BUph0fyvfGTlVKGyGWZajFad/QtP/kWG6ViSpBttIGOBTGdhrQKV/isEOkNiyNxkHl6OT1JMD67Ja4oF2pkSdtFT52dmIKyK9QtUdwOh6VsNvQn6yx8c6/sduHNB6w18nfrLc8ldYE0iAE=
Received: by 10.142.217.17 with SMTP id p17mr1814177wfg.139.1209432352002;
        Mon, 28 Apr 2008 18:25:52 -0700 (PDT)
Received: by 10.142.170.10 with HTTP; Mon, 28 Apr 2008 18:25:51 -0700 (PDT)
In-Reply-To: <2D3D2E55-74C7-4373-BC22-9CF4C26C197D@newartisans.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/80638>

On Mon, Apr 28, 2008 at 2:39 AM, John Wiegley <johnw@newartisans.com> wrote:
> I published another tutorial on Git today, this one describing the system
> from a "bottom up" perspective.  I know it's been written about this way
> before, but I was aiming at a bit more thoroughness, and a paced
> introduction to the basics.
>
>  There's a link to the PDF is in the following blog post:
>
>   http://www.newartisans.com/blog_files/git.from.bottom.up.php

The arrows in your diagrams go the opposite way I expected, but I
might have been execting the wrong thing.
