From: "Marco Costalba" <mcostalba@gmail.com>
Subject: Re: qgit4 and top of git tree
Date: Sun, 25 Feb 2007 18:39:40 +0100
Message-ID: <e5bfff550702250939m14e27e21m88078aad1bb1c72a@mail.gmail.com>
References: <cc723f590702240803o24ca01ffxfea904bf7b11c05@mail.gmail.com>
	 <e5bfff550702250902q11b74fecvce1ea9d79dec8f92@mail.gmail.com>
	 <cc723f590702250925m3795ca58w7e276d2c61fa8f19@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: "Git Mailing List" <git@vger.kernel.org>,
	"Andy Parkins" <andyparkins@gmail.com>
To: "Aneesh Kumar" <aneesh.kumar@gmail.com>
X-From: git-owner@vger.kernel.org Sun Feb 25 18:39:46 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HLNLd-0007Zf-R5
	for gcvg-git@gmane.org; Sun, 25 Feb 2007 18:39:46 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965019AbXBYRjn (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 25 Feb 2007 12:39:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965031AbXBYRjn
	(ORCPT <rfc822;git-outgoing>); Sun, 25 Feb 2007 12:39:43 -0500
Received: from wr-out-0506.google.com ([64.233.184.229]:29446 "EHLO
	wr-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S965019AbXBYRjm (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 25 Feb 2007 12:39:42 -0500
Received: by wr-out-0506.google.com with SMTP id 37so341682wra
        for <git@vger.kernel.org>; Sun, 25 Feb 2007 09:39:42 -0800 (PST)
DKIM-Signature: a=rsa-sha1; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=Dd8Q/vD3W3J74jgDWrj0S09y34wASYFi2pTKofmM4hWSc0XSj7uRdorzUcGx0wOIY7cU3Ql7taeb9sgk2ayPJ/qllB/sAmrh05CPpWAAkqCXR/y/kfyS6vzfs9fsIRV4AYhCzMHQm/FpJFG8o1qnQr11q3O2D8mxMnRNIXnnmO8=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=JwuDd79MaSS7Vn2Yn0OyoPD1IzQSPcrYkF8hzmKvXLTwIQeoOLE8e/xT2NWs1pJ35R15H5HY5fQakClGlZThiVFt0KBnzjlpLzzLpmpCRTATidEJupBeRzEQQ6w1TLjmyrbK1FlcGbfrF6aoMkQBdYoiGhwVpZgHXoP2jdUy0Uo=
Received: by 10.114.155.1 with SMTP id c1mr1036959wae.1172425180287;
        Sun, 25 Feb 2007 09:39:40 -0800 (PST)
Received: by 10.114.60.16 with HTTP; Sun, 25 Feb 2007 09:39:40 -0800 (PST)
In-Reply-To: <cc723f590702250925m3795ca58w7e276d2c61fa8f19@mail.gmail.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/40560>

On 2/25/07, Aneesh Kumar <aneesh.kumar@gmail.com> wrote:
>
> I liked the new look. Is it possible to make the header background
> color fill horizontally.
>

I'm absolutely zero with HTML, all the credits goes to Andy.

In case you would like to try yourself, corresponding code is in git.cpp,
function Git::getDesc(), otherwise I would ask to Andy ;-)

Marco
