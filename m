From: Caleb Cushing <xenoterracide@gmail.com>
Subject: can't clone repo with cygwin 1.7.0
Date: Sun, 12 Apr 2009 17:14:57 -0400
Message-ID: <81bfc67a0904121414u4a94bb56i291ad191c7fad764@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Apr 12 23:20:14 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Lt75v-0001V4-CU
	for gcvg-git-2@gmane.org; Sun, 12 Apr 2009 23:20:03 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751216AbZDLVO7 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 12 Apr 2009 17:14:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751037AbZDLVO7
	(ORCPT <rfc822;git-outgoing>); Sun, 12 Apr 2009 17:14:59 -0400
Received: from yw-out-2324.google.com ([74.125.46.28]:15252 "EHLO
	yw-out-2324.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750763AbZDLVO6 (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 12 Apr 2009 17:14:58 -0400
Received: by yw-out-2324.google.com with SMTP id 5so1949009ywb.1
        for <git@vger.kernel.org>; Sun, 12 Apr 2009 14:14:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:date:message-id:subject
         :from:to:content-type:content-transfer-encoding;
        bh=sIJpBBptuC/YRqHlm9dhVnW4OwlENiCaX9hOX9tRe6w=;
        b=YVWAkiSA0kRVdCFp+ylGb9V2p2M/rl1hda/V7/0DrDZeuAf6BjCWMqgCaSILNlCate
         Mb9EK7TWh5lAsygEiu5u2m4IFHykvG60/qTdZX+UMR3MHEOiGztAtm5XNBy+IqvQf9GN
         Mk2M3H68HUXRkn9b385HAXiystYgx6Q4cV/D0=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:date:message-id:subject:from:to:content-type
         :content-transfer-encoding;
        b=ct7hNZi5k2MScKLOLggCyRgLfd50/BER1Nu7vFngxvx9JbdklsMaxa4k/Fj1INLCXc
         vad4VGB2+QwU95p/CiO6xeU9VS+tSVnG8bJF8i+3NWmxfVOJ7Qfdbk5yCknrW4Ku0sr7
         yKUHeN+wBg40P4fXFqBlgdLy6oJTsQNFoh8cQ=
Received: by 10.100.151.8 with SMTP id y8mr6234011and.106.1239570897261; Sun, 
	12 Apr 2009 14:14:57 -0700 (PDT)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/116393>

git://github.com/xenoterracide/school.git something about a bad
packfile sorry I don't have the error in front of me... I just cloned
it fine on linux though. so maybe a bug in the cygwin version?

-- 
Caleb Cushing

http://xenoterracide.blogspot.com
