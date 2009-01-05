From: Robin Rosenberg <robin.rosenberg.lists@dewire.com>
Subject: Re: [EGIT PATCH] Sorting commit items by click on the table header in commit dialog.
Date: Mon, 5 Jan 2009 08:35:19 +0100
Message-ID: <200901050835.20038.robin.rosenberg.lists@dewire.com>
References: <gjre95$4cs$1@ger.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: "Vasyl' Vavrychuk" <vvavrychuk@gmail.com>,
	"Shawn O. Pearce" <spearce@spearce.org>
X-From: git-owner@vger.kernel.org Mon Jan 05 08:36:56 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LJk18-0001Pz-GW
	for gcvg-git-2@gmane.org; Mon, 05 Jan 2009 08:36:54 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751405AbZAEHf1 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 5 Jan 2009 02:35:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751402AbZAEHf1
	(ORCPT <rfc822;git-outgoing>); Mon, 5 Jan 2009 02:35:27 -0500
Received: from mail.dewire.com ([83.140.172.130]:27202 "EHLO dewire.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751362AbZAEHf0 convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 5 Jan 2009 02:35:26 -0500
Received: from localhost (localhost [127.0.0.1])
	by dewire.com (Postfix) with ESMTP id 27834802A88;
	Mon,  5 Jan 2009 08:35:23 +0100 (CET)
X-Virus-Scanned: by amavisd-new at dewire.com
Received: from dewire.com ([127.0.0.1])
	by localhost (torino.dewire.com [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id J2JCCUnWRiwI; Mon,  5 Jan 2009 08:35:22 +0100 (CET)
Received: from sleipner.localnet (unknown [10.9.0.3])
	by dewire.com (Postfix) with ESMTP id 7914F80069F;
	Mon,  5 Jan 2009 08:35:22 +0100 (CET)
User-Agent: KMail/1.10.3 (Linux/2.6.27-11-generic; KDE/4.1.3; i686; ; )
In-Reply-To: <gjre95$4cs$1@ger.gmane.org>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/104568>

s=F6ndag 04 januari 2009 23:46:47 skrev Vasyl' Vavrychuk:
> In order to implement new feature I have replaced class associated wi=
th every table row.
> CommitItem class encapsulate data that commit dialog manipulates with=
=2E
> Comparators are written using idiom from http://tobega.blogspot.com/2=
008/05/beautiful-enums.html.
> Clicks on a certain column are handled in HeaderSelectionListener cla=
ss.

Hmm. This one cannot be applied on top of master. There is only only on=
e commit on Dec 8
that involves the same file, so If you could rebase that would be nice.=
 Other than that it looks ok.

Please also Cc me and Shawn on patches to reduce the risk of them getti=
ng lost.

-- robin
