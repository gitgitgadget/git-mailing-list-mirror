From: Douglas Mencken <dougmencken@gmail.com>
Subject: Re: [regression] Newer gits cannot clone any remote repos
Date: Tue, 13 Nov 2012 15:33:43 -0500
Message-ID: <CACYvZ7h7eTM0RGchG9SWRoEjvzLN0hYq6ARiJhyXov1VVX+UKg@mail.gmail.com>
References: <CACYvZ7jPd0_XD6YVdfJ2AnKRnKewmzX4uu7w3zt+_gK+qU49gQ@mail.gmail.com>
	<50A2978D.6080805@ramsay1.demon.co.uk>
	<CACYvZ7jMC5xw4LxiuG5m+=grpQEg+wZb_7BaU4Xn-r7ix=S-bw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: git@vger.kernel.org
To: Ramsay Jones <ramsay@ramsay1.demon.co.uk>
X-From: git-owner@vger.kernel.org Tue Nov 13 21:34:00 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TYNBH-0002ds-Fj
	for gcvg-git-2@plane.gmane.org; Tue, 13 Nov 2012 21:33:59 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755814Ab2KMUdp (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 13 Nov 2012 15:33:45 -0500
Received: from mail-la0-f46.google.com ([209.85.215.46]:44691 "EHLO
	mail-la0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755796Ab2KMUdo (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 13 Nov 2012 15:33:44 -0500
Received: by mail-la0-f46.google.com with SMTP id h6so5770281lag.19
        for <git@vger.kernel.org>; Tue, 13 Nov 2012 12:33:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=SSUCkU/p+F3iyMubD31NmkDkJssAx3vAHEGcYQCkuBk=;
        b=RghhD6v2XNeoR5PKPtawFxAq4OSsgPtFvKaNP5j9tuWVv4TKVBesH7b4LaBxim2ywf
         OYQkTEiEJ+Ug2vB8WBU2FvJ5s6lLnHotl98AjE7qhrw8CRPJ+pwTi/UOXHx8TuwbT7Wk
         LTzRxq5QUYe09NBJeEx9AV8x/lXFd313blvyzdD4snsR1ZXC/zQSWaIWwkuKolcElTCI
         NRXhegcadYbvQGFVEPqv7VXbt3O0IbeLl1hJcGa1DW6b5xXyTogpTMkoNadvdKMUpL1w
         BuhIiJwQq64RlRHbEuttybH7BzYl8JSnSEMuLVKJ89tvQE9Fka8q/NFRCJfDi+f44Kg+
         zqqw==
Received: by 10.152.162.1 with SMTP id xw1mr15290275lab.3.1352838823130; Tue,
 13 Nov 2012 12:33:43 -0800 (PST)
Received: by 10.112.22.6 with HTTP; Tue, 13 Nov 2012 12:33:43 -0800 (PST)
In-Reply-To: <CACYvZ7jMC5xw4LxiuG5m+=grpQEg+wZb_7BaU4Xn-r7ix=S-bw@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/209669>

By the way, it is the job of autotools to check such stuff, isn't it?
