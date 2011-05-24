From: "Stefan-W. Hahn" <stefan.hahn@s-hahn.de>
Subject: Re: commit a1f6baa5 (wrap long header lines) breaks my habit
Date: Tue, 24 May 2011 18:46:16 +0200
Organization: -no organization-
Message-ID: <20110524164616.GB7723@scotty.home>
References: <20110524160253.GA7723@scotty.home>
 <7vboys83nh.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue May 24 18:46:28 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QOukT-0003bM-2V
	for gcvg-git-2@lo.gmane.org; Tue, 24 May 2011 18:46:25 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754053Ab1EXQqU (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 24 May 2011 12:46:20 -0400
Received: from moutng.kundenserver.de ([212.227.126.187]:53145 "EHLO
	moutng.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753272Ab1EXQqT (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 24 May 2011 12:46:19 -0400
Received: from scotty.home (port-92-196-58-134.dynamic.qsc.de [92.196.58.134])
	by mrelayeu.kundenserver.de (node=mrbap3) with ESMTP (Nemesis)
	id 0MD8ge-1QSD4Q0ZJM-00GbZh; Tue, 24 May 2011 18:46:18 +0200
Received: from scotty.home (hs@localhost [127.0.0.1])
	by scotty.home (8.14.3/8.14.3/Debian-9.4) with ESMTP id p4OGkHq2016982;
	Tue, 24 May 2011 18:46:17 +0200
Received: (from hs@localhost)
	by scotty.home (8.14.3/8.14.3/Submit) id p4OGkG2L016980;
	Tue, 24 May 2011 18:46:16 +0200
X-Authentication-Warning: scotty.home: hs set sender to stefan.hahn@s-hahn.de using -f
Content-Disposition: inline
In-Reply-To: <7vboys83nh.fsf@alter.siamese.dyndns.org>
X-Mailer: Mutt 1.5.20 (2009-06-14) http://www.mutt.org/
X-Editor: GNU Emacs 23.2.1 http://www.gnu.org/
X-Accept-Language: de en
X-Location: Europe, Germany, Wolfenbuettel
X-GPG-Public-Key: gpg --keyserver keys.gnupg.net --recv-keys E4FCD563
X-GPG-key-ID/Fingerprint: 0xE4FCD563 / EF09 97BB 3731 7DC7 25BA 5C39 185C
 F986 E4FC D563
User-Agent: Mutt/1.5.20 (2009-06-14)
X-Virus-Scanned: clamav-milter 0.97 at scotty
X-Virus-Status: Clean
X-Provags-ID: V02:K0:z+2XGVSJ008yL7lmG5YLhAIuuvKC94g2wMIDh35OhaX
 7uEjnWEYLPmCrN5YtMyi8MBbAckXiuG/HFnjeNRjRDCSiYC7m7
 YIgoJUdO3gUbLyXN0mc+C+b4RvimpsGgJ2pAphXST+QE+rAlRf
 NpB6AOIGxWyQ3RUJQWPD/1qUQaABPm8yTO2cLKPpOuhiKJOFCh
 m7kLoXe9DBLD+5uDM0ltg==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/174331>

Mail von Junio C Hamano, Tue, 24 May 2011 at 09:27:46 -0700:

> >    git format-patch -k --stdout a..b | git am -k -3
> 
> Why -k to am?

Just first "-k", and "git am -3". Wrong in mind here at home before my
computer.

Stefan

-- 
Stefan-W. Hahn                          It is easy to make things.
                                        It is hard to make things simple.
