From: "Paulo J. Matos" <pocm@soton.ac.uk>
Subject: Which content is not indexed?
Date: Mon, 21 Apr 2008 00:36:42 +0100
Message-ID: <11b141710804201636s7a35db7aydcbcafafabf7a4ee@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Apr 21 01:37:58 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Jnj6b-0006ag-L9
	for gcvg-git-2@gmane.org; Mon, 21 Apr 2008 01:37:58 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751314AbYDTXgx (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 20 Apr 2008 19:36:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750931AbYDTXgx
	(ORCPT <rfc822;git-outgoing>); Sun, 20 Apr 2008 19:36:53 -0400
Received: from yw-out-2324.google.com ([74.125.46.30]:20843 "EHLO
	yw-out-2324.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750800AbYDTXgw (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 20 Apr 2008 19:36:52 -0400
Received: by yw-out-2324.google.com with SMTP id 5so874555ywb.1
        for <git@vger.kernel.org>; Sun, 20 Apr 2008 16:36:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:sender:to:subject:mime-version:content-type:content-transfer-encoding:content-disposition:x-google-sender-auth;
        bh=ymYMZCQ8XwPx5aelmfuzPLB9RqAR5i0w7hNfrA1skyM=;
        b=JV1Fe/pl+wlWv6lanf9edvUosPjhTyl4SLQ3hLqbhllFwptVyxSwHvbkwwHlr1QHAOoaiWxOpRGsSAcJG+apfs/SISxBp6BmH7w4jM6U00SioTWWWqKFvDgcEKMV8WOu9ju3Ob39OeYMGDXGZa8ux2FWdAxWcGYCKyoDJvcfyfE=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:sender:to:subject:mime-version:content-type:content-transfer-encoding:content-disposition:x-google-sender-auth;
        b=X28kWetvsho+x47w9D+NEjRHNk94uPTtj9KznkhJVZ3X1MF7iiKhosFjD/uJOJFabTQtnQTRISBHwD+GxPoepJ+LliBob8bUYxp+Nd3M153SJBVptaIaIngDfrgdzIs70/LZ+LK+s5Jqt/CxD1ZqDqZVLKwzE3pCn9boGa8RtiU=
Received: by 10.150.178.6 with SMTP id a6mr6292400ybf.91.1208734602450;
        Sun, 20 Apr 2008 16:36:42 -0700 (PDT)
Received: by 10.150.225.2 with HTTP; Sun, 20 Apr 2008 16:36:42 -0700 (PDT)
Content-Disposition: inline
X-Google-Sender-Auth: 00da2cf0ab9f45e1
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/80002>

Hello all,

I just started using git on a new project. I have added some files to
git, commit.
Now I created some more files, added more content. How can I check
which files [content] are not in git yet?

Cheers,

-- 
Paulo Jorge Matos - pocm at soton.ac.uk
http://www.personal.soton.ac.uk/pocm
PhD Student @ ECS
University of Southampton, UK
Sponsor ECS runners - Action against Hunger:
http://www.justgiving.com/ecsrunslikethewind
