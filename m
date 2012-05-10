From: Philippe Vaucher <philippe.vaucher@gmail.com>
Subject: Re: Weird documentation for git commit-tree
Date: Thu, 10 May 2012 18:34:46 +0200
Message-ID: <CAGK7Mr6XCa_fHZ20BFDMb-NG5Ni0AFb9SfawGFEt99K-0qwRqw@mail.gmail.com>
References: <CAGK7Mr4LJxEfG6D3eWMrN9GXywMjSDJ1Ric=4w7SQY=6ZWu3wQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu May 10 18:35:27 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SSWKq-0002sh-UG
	for gcvg-git-2@plane.gmane.org; Thu, 10 May 2012 18:35:25 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756232Ab2EJQfT (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 10 May 2012 12:35:19 -0400
Received: from mail-wg0-f44.google.com ([74.125.82.44]:65074 "EHLO
	mail-wg0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755777Ab2EJQfR (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 10 May 2012 12:35:17 -0400
Received: by mail-wg0-f44.google.com with SMTP id dr13so1612186wgb.1
        for <git@vger.kernel.org>; Thu, 10 May 2012 09:35:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :content-type;
        bh=XQCqeSEeyZgmrUSXm5hXK0LqaiqddtBniI3COWkW7mw=;
        b=ebwDNV1Hvmve2DW6B4kwU2C5bfQ3u/pmdj7bkty47Ygup6BK+g8g96X39xFAUPR11K
         d1RlQqVPanxKTtp9e1WdZ+Mik+462wkjsFUq4cUE15ZaPAZps9VV4wfDU8njGt67qV6g
         mpzi4cTl4CbtW+a/VPW+0KasVeY1h6tV3v9y+O3DDqt7hfh1P6I0dyIEicmrTDDjeSDj
         YCdcGr97TczyEfIBQ+9ch5fj+zj1EZrIxNvnyhF51EAyMfBKiM4VaKwwXUCKkCN3IXV/
         4e6iC7Ek16yifiiW5xo09J089PdiV0TK/uD237OCyNb//Y0vMD/QE1spZQRei+LbBzjz
         QPSg==
Received: by 10.50.173.102 with SMTP id bj6mr3066614igc.45.1336667716412; Thu,
 10 May 2012 09:35:16 -0700 (PDT)
Received: by 10.50.65.101 with HTTP; Thu, 10 May 2012 09:34:46 -0700 (PDT)
In-Reply-To: <CAGK7Mr4LJxEfG6D3eWMrN9GXywMjSDJ1Ric=4w7SQY=6ZWu3wQ@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/197594>

> The man page for git commit-tree shows weird text under the DIAGNOSTICS section:

Online example: http://linux.die.net/man/1/git-commit-tree

Philippe
