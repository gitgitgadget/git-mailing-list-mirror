From: Tor Arvid Lund <torarvid@gmail.com>
Subject: Perforce vcs-helper
Date: Mon, 25 Jan 2010 11:57:41 +0100
Message-ID: <1a6be5fa1001250257s333339fdq9a08e91fdb84fd3d@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Git mailing list <git@vger.kernel.org>
To: Daniel Barkalow <barkalow@iabervon.org>
X-From: git-owner@vger.kernel.org Mon Jan 25 11:57:56 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NZMdi-0002rC-NR
	for gcvg-git-2@lo.gmane.org; Mon, 25 Jan 2010 11:57:51 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753502Ab0AYK5n (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 25 Jan 2010 05:57:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753463Ab0AYK5n
	(ORCPT <rfc822;git-outgoing>); Mon, 25 Jan 2010 05:57:43 -0500
Received: from mail-fx0-f215.google.com ([209.85.220.215]:32782 "EHLO
	mail-fx0-f215.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753276Ab0AYK5m (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 25 Jan 2010 05:57:42 -0500
Received: by fxm7 with SMTP id 7so1884705fxm.28
        for <git@vger.kernel.org>; Mon, 25 Jan 2010 02:57:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:date:message-id:subject
         :from:to:cc:content-type;
        bh=koND3HbHDh5KqkU147sfHxHhZ466+j5JiD5xNvvgU6Y=;
        b=iSj2sBlcG7/m1r0e+3eNngCxZxTxmlTHaYvZZKAkHTw544YiGv4xZ1fMsqPiGdmH0O
         4pdILkPP4TQ9C9lfk3psYjtqelyWCdUFdLm3Km0BjkXNnvVKptCeI53KcB02d6OTF7gt
         ZZlPR7pbPv3AmYLD73En+vfJzKSmDxaAbW99I=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:date:message-id:subject:from:to:cc:content-type;
        b=Iu3DM1sTnzfE67yzBH3by/hQytJeR0BVFMMpukClDCGOj+6J5beD8245i4K5Iswq5D
         NVhQIFkZNeTo6WMxZj3jEFPGFmfrCupEq3kJMUD4aLSnToMk5HtoTX+fops2cBi0kfIS
         HwlUnAi1fFmvUGSZCs/GNvWQcLPrurNscmxdM=
Received: by 10.239.166.18 with SMTP id z18mr123168hbd.47.1264417061122; Mon, 
	25 Jan 2010 02:57:41 -0800 (PST)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/137948>

Hi, Daniel.

I remember that you posted a vcs-p4 transport helper last year... And
I basically wondered whether or not that is something that you're
still working on. As I understand it, the transport helper framework
will be part of git 1.7, and I thought it would be interesting to test
your code.

The current git-p4 script is nice, of course, but I would much like to
try the "detect branches and integrations" stuff :-)

All the best,
-Tor Arvid-
