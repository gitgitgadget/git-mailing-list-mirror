From: Catalin Pol <catalin.pol@gmail.com>
Subject: a small git proposal
Date: Thu, 23 Aug 2012 18:10:07 +0300
Message-ID: <CACZFoOGjRX_CT5hpYcqN4_67he5gyAC-oGaPwZfcOx6w4QuxVQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary=f46d042fd8743bcfbf04c7f04153
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Aug 23 17:10:23 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1T4Z37-0004Mr-AA
	for gcvg-git-2@plane.gmane.org; Thu, 23 Aug 2012 17:10:21 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752607Ab2HWPKK (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 23 Aug 2012 11:10:10 -0400
Received: from mail-ob0-f174.google.com ([209.85.214.174]:56984 "EHLO
	mail-ob0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751879Ab2HWPKI (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 23 Aug 2012 11:10:08 -0400
Received: by obbuo13 with SMTP id uo13so1815609obb.19
        for <git@vger.kernel.org>; Thu, 23 Aug 2012 08:10:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:date:message-id:subject:from:to:content-type;
        bh=UDkasYSJ1RFSg7Rw33WuQa2cDI33IVZI5shSeyjgpNg=;
        b=Ww9aEK5gbeaKRNaVWC6Zlx1ivvj6XGXDlc8JX4LbA8QXt/BlmUXWHFW+Jsrqj8xdCs
         vp6sUFv9Zx5ldSTQ9RURp0gGxzCzndeQBnoeRDMtjNmTx7BPfraaE/9P2+Es9DJPNDgP
         0MaIbTCboK4A0SLolfZsHbzzcai5ttz/ZonuJiYORi1oUgw22ck0bqfGHZ+mueIQBECe
         4/XgJY0a83SlACslIo5doVFdyuODv+dunKV6djPRKvMDO8AK7HfqQ45NWkEASek6sZ/D
         L6chf4uv85H14Fl+4QdnOUYBke03xhL+Ced/P2boXH+rzLS2vp86nD+p8tlCE4N2KXrg
         Dupw==
Received: by 10.50.53.171 with SMTP id c11mr1893273igp.57.1345734607359; Thu,
 23 Aug 2012 08:10:07 -0700 (PDT)
Received: by 10.64.54.66 with HTTP; Thu, 23 Aug 2012 08:10:07 -0700 (PDT)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/204150>

--f46d042fd8743bcfbf04c7f04153
Content-Type: text/plain; charset=ISO-8859-1

Hi everyone,


This is my first email to this mailing list, so this may be somehow
too straight forward... the idea is that I was thinking to develop a
new feature in Git (although I'm kind of new to git myself).
I wrote a small description of what I intend to do and I figured I
could use some pointers (how I can improve it, any possible usage
scenarios you can think for it and so on). Details are available at
the gist link below or as attachment to this email (I zipped the text
file since it was more it is larger than 10k and I didn't want it to
get rejected by the email server... although it still might)

gist link:    https://gist.github.com/3437530

I made the gist public, so feel free to edit it directly... or, if you
prefer, just email me with any comments. I'm opened to any suggestion,
so feel free to send me any kind of comment (maybe I'm trying to
implement something that is already in git for example, and since I'm
a bit of a newbie in the git world, I didn't notice any way to obtain
my desired workflow).




Thanks in advance for any feedback,

Cata

--f46d042fd8743bcfbf04c7f04153
Content-Type: application/zip; name="feature_tags.zip"
Content-Disposition: attachment; filename="feature_tags.zip"
Content-Transfer-Encoding: base64
X-Attachment-Id: f_h67z5yp60

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
EQAAAAA=
--f46d042fd8743bcfbf04c7f04153--
