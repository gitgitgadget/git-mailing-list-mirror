From: Drew Northup <drew.northup@maine.edu>
Subject: Re: [PATCH 5/7] your file
Date: Fri, 13 May 2011 12:58:03 -0400
Message-ID: <1305305883.1177.10.camel@drew-northup.unet.maine.edu>
References: <1305292458-3920-1-git-send-email-okano.osamu@gmail.com>
	 <1305292458-3920-6-git-send-email-okano.osamu@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Osamu OKANO <okano.osamu@gmail.com>
X-From: git-owner@vger.kernel.org Fri May 13 18:58:19 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QKvgu-00050N-Oc
	for gcvg-git-2@lo.gmane.org; Fri, 13 May 2011 18:58:17 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759641Ab1EMQ6M (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 13 May 2011 12:58:12 -0400
Received: from beryl.its.maine.edu ([130.111.32.94]:42775 "EHLO
	beryl.its.maine.edu" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1759625Ab1EMQ6L (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 13 May 2011 12:58:11 -0400
Received: from [IPv6:2610:48:100:827:211:43ff:fe9f:cb7e] (drew-northup.unet.maine.edu [IPv6:2610:48:100:827:211:43ff:fe9f:cb7e])
	by beryl.its.maine.edu (8.13.8/8.13.8) with ESMTP id p4DGw82u020562
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NOT);
	Fri, 13 May 2011 12:58:08 -0400
In-Reply-To: <1305292458-3920-6-git-send-email-okano.osamu@gmail.com>
X-Mailer: Evolution 2.12.3 (2.12.3-8.el5_2.3) 
X-DCC-URT-Metrics: beryl.its.maine.edu 1060; Body=2 Fuz1=2 Fuz2=2
X-MailScanner-Information: Please contact the ISP for more information
X-UmaineSystem-MailScanner-ID: p4DGw82u020562
X-MailScanner: Found to be clean
X-MailScanner-From: drew.northup@maine.edu
X-UmaineSystem-MailScanner-Watermark: 1305910689.17639@eB+nAqMzfSXOKddr9A1Tjg
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/173552>


On Fri, 2011-05-13 at 22:14 +0900, Osamu OKANO wrote:
> ---
>  Documentation/git-stage.txt |    2 +-
>  1 files changed, 1 insertions(+), 1 deletions(-)
> 
> diff --git a/Documentation/git-stage.txt b/Documentation/git-stage.txt
> index ba3fe0d..8fcb93c 100644
> --- a/Documentation/git-stage.txt
> +++ b/Documentation/git-stage.txt
> @@ -3,7 +3,7 @@ git-stage(1)
>  
>  NAME
>  ----
> -git-stage - Add file contents to the staging area
> +git-stage - Add your file contents to the staging area

Is the demarcation of file ownership (the audience) required in the
translation? I suspect that the English original was left vague on that
point for a reason (the file could be yours, his, hers, or its). If a
change in the demarcation of the audience is required in the translation
I suggest doing such changes there and leaving the source text intact as
different natural languages approach this matter differently. 
As an example, some languages require that the text be reworded
literally to: "Add the contents of the file to the staging area" as it
stands, being rather different from "Add the contents of the file
of/from [belonging to] you to the staging area"; there is advantage to
leaving this text as-is.

-- 
-Drew Northup
________________________________________________
"As opposed to vegetable or mineral error?"
-John Pescatore, SANS NewsBites Vol. 12 Num. 59
