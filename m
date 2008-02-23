From: "J.C. Pizarro" <jcpiza@gmail.com>
Subject: How small is git-packed mailing list vs zipped mailing list?
Date: Sat, 23 Feb 2008 06:03:08 +0100
Message-ID: <998d0e4a0802222103x7b42b849q950a2a3c9b0d3550@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Feb 23 06:04:12 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JSmYV-0004f1-Hy
	for gcvg-git-2@gmane.org; Sat, 23 Feb 2008 06:04:12 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750733AbYBWFDL (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 23 Feb 2008 00:03:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750712AbYBWFDK
	(ORCPT <rfc822;git-outgoing>); Sat, 23 Feb 2008 00:03:10 -0500
Received: from wx-out-0506.google.com ([66.249.82.224]:57819 "EHLO
	wx-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750708AbYBWFDI (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 23 Feb 2008 00:03:08 -0500
Received: by wx-out-0506.google.com with SMTP id h31so602339wxd.4
        for <git@vger.kernel.org>; Fri, 22 Feb 2008 21:03:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:mime-version:content-type:content-transfer-encoding:content-disposition;
        bh=6veSMY5AVcTwefCBI4NgY4Iu8CrR9asRl/nJbUdkpJY=;
        b=DfxLW6ozUJJHgJcmGWgC8hGtddBxKrOK0gBKkWM52vYR8zRHD2oeptcfWWyBDxRW8k2VAGKTvYJO534T+iWrwY5oabz7FxGv9CORAvukbyTbw5SVBVHP4Em+Cso6RRiGZ1AJTUgx43I/Ead8Af/oyfgKk8cu2DSD/FQvE5KwGJg=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:to:subject:mime-version:content-type:content-transfer-encoding:content-disposition;
        b=uSxoG+OeLCTlaQ+42kQ5CtWDhebGcL3cT39N6TK1RC/DaBYGyjz7w8XUo5CMOn0vr0Pdu58e+ZYsHAWla/kCwKtTaQ9+mlgzznPG9/Qp6lxV3OI/pX61Q85nTWWefsqsIgFJXTLzTCe/cgrbWdVys5CtlHRD+tDadR4TEYjMVC0=
Received: by 10.70.70.12 with SMTP id s12mr563085wxa.78.1203742988090;
        Fri, 22 Feb 2008 21:03:08 -0800 (PST)
Received: by 10.70.40.12 with HTTP; Fri, 22 Feb 2008 21:03:08 -0800 (PST)
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/74799>

Not all inside of git repository data is source code used for
versioning control, but the mailing lists are pushed too into git repo!

Is there any idea of

How small is a git packed mailing list vs zipped mailing list?

   ;)
