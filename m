From: Marcus <prima@wordit.com>
Subject: Clean master, version tags
Date: Mon, 19 May 2008 03:21:21 +0100
Message-ID: <8345bd80805181921l36451957s2063395c65a42aea@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon May 19 04:23:15 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Jxv1M-0005cP-HA
	for gcvg-git-2@gmane.org; Mon, 19 May 2008 04:22:40 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753425AbYESCVX (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 18 May 2008 22:21:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753160AbYESCVX
	(ORCPT <rfc822;git-outgoing>); Sun, 18 May 2008 22:21:23 -0400
Received: from rv-out-0506.google.com ([209.85.198.233]:51820 "EHLO
	rv-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753107AbYESCVW (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 18 May 2008 22:21:22 -0400
Received: by rv-out-0506.google.com with SMTP id l9so1215644rvb.1
        for <git@vger.kernel.org>; Sun, 18 May 2008 19:21:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:sender:to:subject:mime-version:content-type:content-transfer-encoding:content-disposition:x-google-sender-auth;
        bh=pll4Rg76DGwk1t5bSoObuAOfdUGCcK9Y9gPv1CNNpJk=;
        b=n3u+RmLNHOAyeCwpFC94j+KmCS33aQslof8bBpbpUSxW4xr28PnOdV/nvNruGm3pAx0ABEuGo2TMD9PtTb0rZzXk+mbXoeSST39+O5RIMiOfVukPYDa5w7mNV+iNVUp1P0elctQpaw4usJUjy3bGFkV2G915VPZJfsqVYkMD6M0=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=googlemail.com; s=gamma;
        h=message-id:date:from:sender:to:subject:mime-version:content-type:content-transfer-encoding:content-disposition:x-google-sender-auth;
        b=Dm+RRmqFiz7ep5FZVXT3lasi9KPOAQ+blDcyu0/noKK2f/3ZLGiBu1zIGD44xpKpI72TCxcVezar2rMiFXOva8EZWDVyS5fLWFGnnzmNENk/+KqL5YjW8Hy6QUQQzxjdmlFfd/MAUQCTQGjOTDBfob3DcZdLdAVZRnPFzsWw3XA=
Received: by 10.140.203.15 with SMTP id a15mr3350054rvg.212.1211163681502;
        Sun, 18 May 2008 19:21:21 -0700 (PDT)
Received: by 10.141.212.7 with HTTP; Sun, 18 May 2008 19:21:21 -0700 (PDT)
Content-Disposition: inline
X-Google-Sender-Auth: 779a38eca6e85c74
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/82404>

I created a lot of test files in the master, branch before Iearning
how to use branches. How do I safely remove all entries in master. The
branch should can be completely cleaned and leave no traces, so we
have a fresh start.

2) Is there a tutorial on how to tag versions and use the version name
as reference?

Thanks,

Marcus
