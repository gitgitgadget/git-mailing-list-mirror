From: "Catalin Marinas" <catalin.marinas@gmail.com>
Subject: Re: [StGit PATCH 0/4] More tutorial updates
Date: Sun, 12 Oct 2008 23:10:04 +0100
Message-ID: <b0943d9e0810121510p3aa1d9fbo232a24c6c8ee223a@mail.gmail.com>
References: <20081012150825.17648.3315.stgit@yoghurt>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: "=?ISO-8859-1?Q?Karl_Hasselstr=F6m?=" <kha@treskal.com>
X-From: git-owner@vger.kernel.org Mon Oct 13 00:11:32 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Kp99r-0000Ey-SZ
	for gcvg-git-2@gmane.org; Mon, 13 Oct 2008 00:11:28 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753410AbYJLWKJ convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 12 Oct 2008 18:10:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752369AbYJLWKJ
	(ORCPT <rfc822;git-outgoing>); Sun, 12 Oct 2008 18:10:09 -0400
Received: from rv-out-0506.google.com ([209.85.198.235]:21294 "EHLO
	rv-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752109AbYJLWKI convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 12 Oct 2008 18:10:08 -0400
Received: by rv-out-0506.google.com with SMTP id k40so1542766rvb.1
        for <git@vger.kernel.org>; Sun, 12 Oct 2008 15:10:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to
         :subject:cc:in-reply-to:mime-version:content-type
         :content-transfer-encoding:content-disposition:references;
        bh=NBgM06cZVQjgE+o9nJCcTIccRI9jKI2bUg9U6Kck0kU=;
        b=Zr7JOt6qq2Jk6xzy3HrqHmKtWNXaTYDeJTiJGvOuLvOPbf/GlDyy+hslJXH8+V/Hlg
         tSvHa/DsBGRj/+fcXYqvvZZNj2nwJpVC3RfZIbQrXgnit96yD27CBHrHTUCRmGAbs3vX
         lUOjgf7DN42O7O/apfyHuZPj7nIi5uFUTomLU=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:to:subject:cc:in-reply-to:mime-version
         :content-type:content-transfer-encoding:content-disposition
         :references;
        b=MqVUM/cRdynpA8zlMiaMpsWXNyTFP3mEoGrgZYZJgW4NLd4Dqn9WmD1wAXBu12L1cF
         MajEA+gVavPhO5H4l90+afNzxjRaIVxI7i9Mcr8OiLidQMythnS6pcXSPT+Pqf1zU71L
         qLejzwDsqEKmzGCLBhJOHD33kjY7DqqowGx0E=
Received: by 10.140.162.21 with SMTP id k21mr3164571rve.110.1223849404454;
        Sun, 12 Oct 2008 15:10:04 -0700 (PDT)
Received: by 10.141.201.12 with HTTP; Sun, 12 Oct 2008 15:10:04 -0700 (PDT)
In-Reply-To: <20081012150825.17648.3315.stgit@yoghurt>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/98060>

2008/10/12 Karl Hasselstr=F6m <kha@treskal.com>:
> More updates to the tutorial. I'd really appreciate if people would
> sanity check these; a bad tutorial tends to reflect negatively on a
> project.

I merge kha/safe into master and I'll post patches against it. Thanks.

--=20
Catalin
