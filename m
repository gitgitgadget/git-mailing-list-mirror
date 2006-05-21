From: "Marco Costalba" <mcostalba@gmail.com>
Subject: First tarball release of qgit with tabs
Date: Sun, 21 May 2006 16:29:09 +0200
Message-ID: <e5bfff550605210729t45fd303n43712a50fcc1dfcd@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
	format=flowed
Content-Transfer-Encoding: 7BIT
X-From: git-owner@vger.kernel.org Sun May 21 16:29:21 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1Fhovp-0001cO-6d
	for gcvg-git@gmane.org; Sun, 21 May 2006 16:29:21 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964882AbWEUO3L (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 21 May 2006 10:29:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964883AbWEUO3L
	(ORCPT <rfc822;git-outgoing>); Sun, 21 May 2006 10:29:11 -0400
Received: from wr-out-0506.google.com ([64.233.184.238]:23740 "EHLO
	wr-out-0506.google.com") by vger.kernel.org with ESMTP
	id S964882AbWEUO3K convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 21 May 2006 10:29:10 -0400
Received: by wr-out-0506.google.com with SMTP id 68so1512252wra
        for <git@vger.kernel.org>; Sun, 21 May 2006 07:29:09 -0700 (PDT)
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:mime-version:content-type:content-transfer-encoding:content-disposition;
        b=FOzBgw9MCOa7e7q4doNNR3dkWrkHzasFNFhIMoydbv7scchvluswVyO9sQrMSPhr/u8uAT2NFyYMTA1loY99rxdM8P2Cbrqs2W48uIV5XXzCANFUvKxabsbBSTA/LMVPCbKU/PAjKGJDbBQ8m+yZ7MAO/Nf41HpOgaVBx8N6Iss=
Received: by 10.64.10.11 with SMTP id 11mr128020qbj;
        Sun, 21 May 2006 07:29:09 -0700 (PDT)
Received: by 10.64.142.14 with HTTP; Sun, 21 May 2006 07:29:09 -0700 (PDT)
To: git@vger.kernel.org
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/20451>

This is qgit1.3rc1

Rewritten a big chunk of UI code and added support for tabbed views
and powerful key bindings. Now should be far easier and quick to
browse through patches.

1.3 release will be mainly about user friendliness. Any suggestion,
comment and of course bug is, as usual, greatly appreciated.

Detailed changelog in shipped file or directly through public git repo.

Note: Sourceforge seems to have some download problem today!

            Marco


Download
--------------

Git archive is at
http://digilander.libero.it/mcostalba/scm/qgit.git

See http://digilander.libero.it/mcostalba/ for detailed download information.


Install
--------

git 1.3.0 is required.

To install from tarball:

./configure
make
make install-strip

To install from git archive:

autoreconf -i
./configure
make
make install-strip

Or check the shipped README for detailed information.
