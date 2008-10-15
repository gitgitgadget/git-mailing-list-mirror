From: "=?ISO-8859-1?Q?Santi_B=E9jar?=" <santi@agolina.net>
Subject: Re: [PATCH v2] describe: Make --tags and --all match lightweight tags more often
Date: Wed, 15 Oct 2008 14:54:14 +0200
Message-ID: <adf1fd3d0810150554k65f66932la30e42e93131a7a8@mail.gmail.com>
References: <20080930083940.GA11453@artemis.corp>
	 <20081010165952.GI8203@spearce.org>
	 <20081010171217.GB29028@artemis.corp>
	 <20081013143946.GP4856@spearce.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: "Junio C Hamano" <gitster@pobox.com>, git@vger.kernel.org,
	"Pierre Habouzit" <madcoder@debian.org>,
	"Erez Zilber" <erezzi.list@gmail.com>,
	"=?ISO-8859-1?Q?Uwe_Kleine-K=F6nig?=" <ukleinek@strlen.de>
To: "Shawn O. Pearce" <spearce@spearce.org>
X-From: git-owner@vger.kernel.org Wed Oct 15 14:55:38 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Kq5uT-0000QN-N0
	for gcvg-git-2@gmane.org; Wed, 15 Oct 2008 14:55:30 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752770AbYJOMyR (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 15 Oct 2008 08:54:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752737AbYJOMyR
	(ORCPT <rfc822;git-outgoing>); Wed, 15 Oct 2008 08:54:17 -0400
Received: from ug-out-1314.google.com ([66.249.92.169]:34255 "EHLO
	ug-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752724AbYJOMyQ (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 15 Oct 2008 08:54:16 -0400
Received: by ug-out-1314.google.com with SMTP id k3so1285287ugf.37
        for <git@vger.kernel.org>; Wed, 15 Oct 2008 05:54:15 -0700 (PDT)
Received: by 10.103.2.14 with SMTP id e14mr519298mui.104.1224075254885;
        Wed, 15 Oct 2008 05:54:14 -0700 (PDT)
Received: by 10.102.247.10 with HTTP; Wed, 15 Oct 2008 05:54:14 -0700 (PDT)
In-Reply-To: <20081013143946.GP4856@spearce.org>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/98271>

> diff --git a/Documentation/git-describe.txt b/Documentation/git-describe.txt
> index c4dbc2a..40e061f 100644
> --- a/Documentation/git-describe.txt
> +++ b/Documentation/git-describe.txt

[...]

> +annotated tags.  For more information about creating annoated tags

s/annoated/annotated/

Santi
