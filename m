From: "Erez Zilber" <erezzi.list@gmail.com>
Subject: Is there a way to diff between a local repository and a remote one?
Date: Sun, 29 Jun 2008 14:29:34 +0300
Message-ID: <ce513bcc0806290429r1982fbf2i4c9a8258bc8db3c@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
To: "git@vger.kernel.org" <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Sun Jun 29 13:31:18 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KCv7i-0001pN-6x
	for gcvg-git-2@gmane.org; Sun, 29 Jun 2008 13:31:14 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753586AbYF2L3f (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 29 Jun 2008 07:29:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753936AbYF2L3f
	(ORCPT <rfc822;git-outgoing>); Sun, 29 Jun 2008 07:29:35 -0400
Received: from rv-out-0506.google.com ([209.85.198.229]:59034 "EHLO
	rv-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753053AbYF2L3f (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 29 Jun 2008 07:29:35 -0400
Received: by rv-out-0506.google.com with SMTP id k40so1231638rvb.1
        for <git@vger.kernel.org>; Sun, 29 Jun 2008 04:29:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to
         :subject:mime-version:content-type:content-transfer-encoding
         :content-disposition;
        bh=yEX16/QrC9vD+JSSWQ3j5JxZRVAEGvK78oM+00rgxiY=;
        b=JuljIgMKyQEURq/cFgU18+ensHMKt86++WWBGqELh0r7DWcoOqSRESM6eTpG30BvSr
         tCMffasiqR4SDSVfiVyvOjuozHxQOF7cy+RF4YQ+MS8nRcbd1GpI3WS7f1PJ8tM8iqn/
         yv8avR08scJQwH05g5hIUBfVE8AFCOcj/xwcI=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:to:subject:mime-version:content-type
         :content-transfer-encoding:content-disposition;
        b=CUoUQVZjZspftV1Y0P289uVO3AUDUR2GjXiJ7KjrXQm0FFjAfjLwPWuVwlQPPpeB1v
         THt2a1dBCmfLtwSDtJyWfhGG7+XZGc0TR2QAXzMHsnskWD14q6iXoORGsS6LtGLOCExV
         lHzbrPw1GrHnyzaAjHGfX11hS8JZN9CDjcSlI=
Received: by 10.141.29.8 with SMTP id g8mr1961210rvj.62.1214738974250;
        Sun, 29 Jun 2008 04:29:34 -0700 (PDT)
Received: by 10.140.136.4 with HTTP; Sun, 29 Jun 2008 04:29:34 -0700 (PDT)
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/86794>

I could clone the remote repository and use Linux's diff, but I prefer
to do it the right way (if possible).

Thanks,
Erez
