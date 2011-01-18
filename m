From: Drew Northup <drew.northup@maine.edu>
Subject: Re: core.whitespace space-in-indent feature request
Date: Tue, 18 Jan 2011 14:51:37 -0500
Message-ID: <1295380297.3778.47.camel@drew-northup.unet.maine.edu>
References: <AANLkTikiHXofGVg9QECg9a4U4r4VGD1tb6oMV21nzd9W@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Victor Engmark <victor.engmark@gmail.com>
X-From: git-owner@vger.kernel.org Tue Jan 18 20:58:58 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PfHhg-0006oD-MC
	for gcvg-git-2@lo.gmane.org; Tue, 18 Jan 2011 20:58:57 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752856Ab1ART6v (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 18 Jan 2011 14:58:51 -0500
Received: from basalt.its.maine.edu ([130.111.32.66]:56182 "EHLO
	basalt.its.maine.edu" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751983Ab1ART6v (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 18 Jan 2011 14:58:51 -0500
Received: from [IPv6:2610:48:100:827:211:43ff:fe9f:cb7e] (drew-northup.unet.maine.edu [IPv6:2610:48:100:827:211:43ff:fe9f:cb7e])
	by basalt.its.maine.edu (8.13.8/8.13.8) with ESMTP id p0IJpgQr011534
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NOT);
	Tue, 18 Jan 2011 14:51:47 -0500
In-Reply-To: <AANLkTikiHXofGVg9QECg9a4U4r4VGD1tb6oMV21nzd9W@mail.gmail.com>
X-Mailer: Evolution 2.12.3 (2.12.3-8.el5_2.3) 
X-DCC-UniversityOfMaineSystem-Metrics: basalt.its.maine.edu 1003; Body=2
	Fuz1=2 Fuz2=2
X-MailScanner-Information: Please contact the ISP for more information
X-UmaineSystem-MailScanner-ID: p0IJpgQr011534
X-MailScanner: Found to be clean
X-MailScanner-From: drew.northup@maine.edu
X-UmaineSystem-MailScanner-Watermark: 1295985125.28504@HSlKRISJ6ZzWrNVFJ+poQg
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/165213>


On Fri, 2011-01-14 at 13:40 +0100, Victor Engmark wrote:
> Hi all,
> 
> I couldn't find this mentioned anywhere, but it would be useful for
> languages where you typically want only tab characters in indentation,
> like makefiles. Would be equivalent or similar to indent-with-non-tab
> and tabwidth=1.

Victor,
What would the point of this be? Git doesn't change the layout of the
code when storing it--that's up to the thing between the chair and the
keyboard.

-- 
-Drew Northup
________________________________________________
"As opposed to vegetable or mineral error?"
-John Pescatore, SANS NewsBites Vol. 12 Num. 59
