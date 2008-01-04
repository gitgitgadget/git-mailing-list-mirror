From: "Marco Costalba" <mcostalba@gmail.com>
Subject: Re: [ANNOUNCE] ugit: the pythonic git gui
Date: Fri, 4 Jan 2008 08:15:54 +0100
Message-ID: <e5bfff550801032315v1d2b98f7s4c22cd466e16f524@mail.gmail.com>
References: <402731c90712281449g3d0c4f53w48c65dc8883bbbb3@mail.gmail.com>
	 <8b65902a0801020242x425b792xbfa5ee69a13c2573@mail.gmail.com>
	 <402731c90801021920h284bb84dn29151dccd90eed2a@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: "Guilhem Bonnefille" <guilhem.bonnefille@gmail.com>,
	git@vger.kernel.org
To: David <davvid@gmail.com>
X-From: git-owner@vger.kernel.org Fri Jan 04 08:16:26 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JAgn3-0008JS-PY
	for gcvg-git-2@gmane.org; Fri, 04 Jan 2008 08:16:26 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752312AbYADHPz (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 4 Jan 2008 02:15:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752590AbYADHPz
	(ORCPT <rfc822;git-outgoing>); Fri, 4 Jan 2008 02:15:55 -0500
Received: from rv-out-0910.google.com ([209.85.198.184]:24751 "EHLO
	rv-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752248AbYADHPz (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 4 Jan 2008 02:15:55 -0500
Received: by rv-out-0910.google.com with SMTP id k20so6024845rvb.1
        for <git@vger.kernel.org>; Thu, 03 Jan 2008 23:15:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        bh=0zUkb+3E3VshSNsidxD+Ul2A8MdP+Nbz+DHpq6xFn9k=;
        b=H9YaMBmhD7r5xPDOmq4jF3mNgQ5ulcHOHZCUIL1s523sHx6cf9mi82MsdosALBMbRoU5g9D5Q+Z8R5eveOd2UdbCiLSXLCMZLDxiZup/aTGHZobb49ngEqNvBA6zbfrImDYTnG1U10lYi0p+ChEmK9Nr0ZfjbynKqXEVN2vVcIw=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=K0nJzlLYZO6CS5bdaojh4iI5+W1mjVgNZghv3vp/uZRispsPKhczFAjmgjyGu8GVws4+t/pBqG5Ihh/3F62Htfvw+9l9ZL0nCeR5mJb03xg0T5zevn4ao9hsgtl7rXF4B49SJaJ9mgfD4q/Q5A2IYRquBst5xdAHcdcXFXtxlcQ=
Received: by 10.140.148.3 with SMTP id v3mr8618555rvd.129.1199430954487;
        Thu, 03 Jan 2008 23:15:54 -0800 (PST)
Received: by 10.141.76.1 with HTTP; Thu, 3 Jan 2008 23:15:54 -0800 (PST)
In-Reply-To: <402731c90801021920h284bb84dn29151dccd90eed2a@mail.gmail.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/69553>

On Jan 3, 2008 4:20 AM, David <davvid@gmail.com> wrote:
>
> I don't have any fancy mac or windows installers at the moment (Linux
> is my primary platform) though I am working on packaging soon.
>

Regarding windows installer I was very happy with Inno Setuo that I
didn't know but I found out be very simple to learn and powerful.

It's a script that you tweak according to your needs, then run the
inno setup compiler on it and that's all. In case you need a script
example just as a starting point you could use the one I have created
for qgit, you can download directly from

http://git.kernel.org/?p=qgit/qgit4.git;a=tree

The script is called qgit_inno_setup.iss


Marco
