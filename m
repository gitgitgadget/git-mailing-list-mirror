From: "Dmitry Kakurin" <dmitry.kakurin@gmail.com>
Subject: MinGW build environment for Git
Date: Sun, 29 Jul 2007 16:14:00 -0700
Message-ID: <a1bbc6950707291614w392bf3a9t5d0d9e50bfcb0f36@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Jul 30 01:14:23 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IFHxu-0000Fm-AH
	for gcvg-git@gmane.org; Mon, 30 Jul 2007 01:14:22 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751135AbXG2XOE (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 29 Jul 2007 19:14:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1764015AbXG2XOB
	(ORCPT <rfc822;git-outgoing>); Sun, 29 Jul 2007 19:14:01 -0400
Received: from rv-out-0910.google.com ([209.85.198.190]:16073 "EHLO
	rv-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754083AbXG2XOB (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 29 Jul 2007 19:14:01 -0400
Received: by rv-out-0910.google.com with SMTP id k20so311154rvb
        for <git@vger.kernel.org>; Sun, 29 Jul 2007 16:14:00 -0700 (PDT)
DKIM-Signature: a=rsa-sha1; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:mime-version:content-type:content-transfer-encoding:content-disposition;
        b=sXOXu5qOPi10hr/sHa0ko9GTFhricIwf4nu/3U8Qt6ho9l+QlgfaXqvs0VWLb0aDMpPKodUOZqZmbhpdCjpJ1CUvkfSwjdB6zjMBHBNtHlZ/YjatSVz93s/e2rnELeBvdOmLVsCj3BSzdbj00k65XHbpD6xFb5gJhgOhUhz4Lf0=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:message-id:date:from:to:subject:mime-version:content-type:content-transfer-encoding:content-disposition;
        b=H/O6bPqMCpY2JWU3wvA1CUhb1MaqqMV1XkJxDZ0vAJgCW9UM7jfuVPPxnGYjFOaIuajcCgbBmnbKh4xK4Ho6fC7CKX3/htaPgmm+/YDflgZX3blB/VZd6mSS9VhnNuVVJhgh2ePq3KLJMlqCLnc/dflrYJjMMUG+eUwE3U0jBtA=
Received: by 10.141.68.10 with SMTP id v10mr1636980rvk.1185750840600;
        Sun, 29 Jul 2007 16:14:00 -0700 (PDT)
Received: by 10.141.2.18 with HTTP; Sun, 29 Jul 2007 16:14:00 -0700 (PDT)
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/54147>

    I want to be able to build MinGW port of Git on Windows.
I've tried to follow steps in README.MinGW to setup this environment
myself (install MinGW, MSys, ZLib etc.) but after wasting a lot of
time with no result I give up.
   So, could somebody please just pkzip their environment (everything
required) and share the zip file with me (privately or publicly)?
   I also think that an even better idea is to create a new Git
repository with MinGW build environment. This will make contributing
to MinGW port of Git MUCH easier.

- Dmitry
