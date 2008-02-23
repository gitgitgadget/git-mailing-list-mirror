From: "Adam Mercer" <ramercer@gmail.com>
Subject: Re: Setting SVN properties with git-svn, and removing empty directories
Date: Sat, 23 Feb 2008 13:23:37 -0500
Message-ID: <799406d60802231023p709cb53ay1a2ecf6b8865b943@mail.gmail.com>
References: <799406d60802230938s559168f8lc9b1f640f2c07fee@mail.gmail.com>
	 <20080223181840.GA30325@atjola.homenet>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: "=?ISO-8859-1?Q?Bj=F6rn_Steinbrink?=" <B.Steinbrink@gmx.de>
X-From: git-owner@vger.kernel.org Sat Feb 23 19:24:17 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JSz2m-0007Ko-Na
	for gcvg-git-2@gmane.org; Sat, 23 Feb 2008 19:24:17 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756654AbYBWSXj convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sat, 23 Feb 2008 13:23:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756209AbYBWSXj
	(ORCPT <rfc822;git-outgoing>); Sat, 23 Feb 2008 13:23:39 -0500
Received: from wf-out-1314.google.com ([209.85.200.174]:3826 "EHLO
	wf-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754153AbYBWSXi convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 23 Feb 2008 13:23:38 -0500
Received: by wf-out-1314.google.com with SMTP id 28so469885wff.4
        for <git@vger.kernel.org>; Sat, 23 Feb 2008 10:23:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        bh=PitDYqm7bHQEoC5+6bJDSaMjhGvvGJsdePH79qUGRXo=;
        b=YEqWhWXo9mhQQXUSBQjXgu3AHY/8Tub6U1xtdAjKlz0/6qgfOWnTzK00b/reknq32u78s5FHRUHcoT+raOn2R+MEyouVzFEHwhVAWer3rHzwK26k0qhc6YPqcmlwOkU4woMH25Ohz2S91lEN2qNfMt76Quv+sjljv505A790MKo=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=HgrUicxfA5EzLRRoVcHBzLz48J4ZYtBsp5mZqxwJFA3TvjRU+txNNEM5rC/Wd6s9xuwX0y3MDRdDdQyLU+v7X0vxQDALLnI2pzP2EeJw64crVqEunPHhlIDF/+GQqgP7Huv68Dd1H6e+X7NMR74QZvLQsnYZH/mAtBSgdkAxA+4=
Received: by 10.142.128.6 with SMTP id a6mr543045wfd.74.1203791017051;
        Sat, 23 Feb 2008 10:23:37 -0800 (PST)
Received: by 10.143.174.2 with HTTP; Sat, 23 Feb 2008 10:23:37 -0800 (PST)
In-Reply-To: <20080223181840.GA30325@atjola.homenet>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/74834>

On Sat, Feb 23, 2008 at 1:18 PM, Bj=F6rn Steinbrink <B.Steinbrink@gmx.d=
e> wrote:

>  Acccording to the man page, you can pass --rmdir to dcommit or set
>  svn.rmdir in the configuration to have git-svn delete empty director=
ies
>  in the SVN repo.

=46antastic, thanks I didn't see that option!

Cheers

Adam
