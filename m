From: "John Norris" <john@norricorp.f9.co.uk>
Subject: Smart HTTP
Date: Mon, 13 Oct 2014 17:29:05 +0000
Message-ID: <em4fcc6297-a9c0-4bcf-b7da-6afb6cbe5f80@mesh>
Reply-To: "John Norris" <john@norricorp.f9.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; format=flowed; charset=utf-8
Content-Transfer-Encoding: 8BIT
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Oct 13 19:29:16 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XdjQp-0005kQ-6b
	for gcvg-git-2@plane.gmane.org; Mon, 13 Oct 2014 19:29:15 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754304AbaJMR3L (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 13 Oct 2014 13:29:11 -0400
Received: from avasout04.plus.net ([212.159.14.19]:48147 "EHLO
	avasout04.plus.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752471AbaJMR3L convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 13 Oct 2014 13:29:11 -0400
Received: from [192.168.1.64] ([84.92.160.245])
	by avasout04 with smtp
	id 2hV71p0035HyN1w01hV8GJ; Mon, 13 Oct 2014 18:29:10 +0100
X-CM-Score: 0.00
X-CNFS-Analysis: v=2.1 cv=V9zz0IXi c=1 sm=1 tr=0
 a=uV5YCD0UIVckYctGSoeXiA==:117 a=uV5YCD0UIVckYctGSoeXiA==:17 a=0Bzu9jTXAAAA:8
 a=PsAntADAv5cA:10 a=w_1ExziR4gQA:10 a=IkcTkHD0fZMA:10 a=GCZBuicCAAAA:8
 a=anyJmfQTAAAA:8 a=d91IFn5of6C25yWIsL4A:9 a=QEXdDO2ut3YA:10 a=4D_qlx4QRscA:10
 a=1R2eHFOlrNcA:10
User-Agent: eM_Client/6.0.20899.0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi,
I guess this comment is aimed at Scott Chacon.
I have read your blog post on Smart HTTP 
(http://git-scm.com/blog/2010/03/04/smart-http.html) and wondered if 
there is any documentation that compares in terms of thoroughness with 
your sections in the book on using SSH, which does explain the basics so 
that "anyone" can get it working.
I have tried setting up authenticated pull and push with HTTP (not 
HTTPS) and Apache never asks for authentication during a pull and 
refuses a push with a 403 error.
Regards,
John Norris
